# An emplementation of a state manager with a support for world/role/user-level masquerading.
# You can simply replace it with your own (e.g. you may not like ActiveRecord, or have different needs for masquerading),
# as long as it implements the following class-methods:
# * +init+ - gets called before anything else, and accepts a hash with the following keys:
#   * +component+ should be set to component's persistence key (e.g. Netzke::Base#global_id)
#   * +current_user+ should be set to the current user object
#   * +session+ should be set to the controller's session
# * +state+ - returns the persistent state (a hash) for the component specified with the +init+ call
# * +update_state+ - accepts a hash, that should get merged with the current +state+
#
# == Assumptions
# This particular implementation assumes the following:
# * ActiveRecord as ORM
# * Current user belong_to Role
# * User#id is user's primary key
# * session[:masquerade_as] is a hash:
#   {:world => true} # to masquerade as World
#   {:role_id => some_role_id} # to masquerade as a role
#   {:user_id => some_user_id} # to masquerade as a user
#
# == Class-level configuration:
# * +masquerade_as_session_key+ - defaults to :masquerade_as
#
class NetzkeComponentState < ActiveRecord::Base
  serialize :value

  class_attribute :masquerade_as_session_key
  self.masquerade_as_session_key = :masquerade_as

  belongs_to :user
  belongs_to :role

  class << self
    def init(config)
      @@config ||= {}
      @@config.merge!(config)
      self
    end

    def session
      @@config[:session]
    end

    def component
      @@config[:component]
    end

    def current_user
      @@config[:current_user]
    end

    def masquerade_as
      session[masquerade_as_session_key]
    end

    def state
      find_state.try(:value)
    end

    def update_state!(hsh)
      state_record = find_state(true)
      new_value = (state_record.value || {}).merge(hsh)
      new_value.delete_if{ |k,v| v.nil? } # setting values to nil means deleting them
      state_record.value = new_value
      state_record.save!

      propagate(hsh)
    end

    private

      def propagate(hsh)
        if masquerade_as.present? && !masquerade_as[:user_id]
          relation = self.where({:component => component})
          if masquerade_as[:role_id]
            relation = relation.includes(:user).where(:users => {:role_id => masquerade_as[:role_id]})
          end
          relation.all.each do |r|
            r.value = r.value.merge(hsh)
            r.save!
          end
        end
      end

      def find_state(or_create_new = false)
        hsh = {:component => component}
        if masquerade_as.present?
          if masquerade_as[:world]
            hsh.merge!(:role_id => 0)
          elsif masquerade_as[:role_id]
            hsh.merge!(:role_id => masquerade_as[:role_id])
          elsif masquerade_as[:user_id]
            hsh.merge!(:user_id => masquerade_as[:user_id])
          end
        elsif current_user
          hsh.merge!(:user_id => current_user.id)
        end

        self.where(hsh).first || (or_create_new ? self.new(hsh) : nil)
      end

  end
end
