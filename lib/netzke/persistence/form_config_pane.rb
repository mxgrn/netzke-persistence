module Netzke
  module Persistence
    # FormPanel-based config pane. Can be used as configuration pane with 'configurable' class method (see +Netzke::Persistence::Configurable+).
    # The values specified in the fields get merged with persistent default config of the configurable component.
    class FormConfigPane < Netzke::Basepack::FormPanel
      def default_config
        super.tap do |c|
          c[:bbar] = false
        end
      end

      def items
        # Add values to the fields
        super.map{ |f| f.merge(:value => persistence_storage[f[:name]]) }
      end

      # This method is expected by the ConfigWindow nesting us
      js_method :get_settings, <<-JS
        function(){
          return this.getForm().getValues();
        }
      JS

      # This method is going to be called by the nesting ConfigWindow
      js_method :apply_settings, <<-JS
        function(callback, scope){
          var settings = this.getForm().getValues();
          this.serverApplySettings(settings, function(res){
            this.lastApplySettingsResult = res;
            callback.call(scope || this, this);
          }, this);
        }
      JS

      js_method :set_last_commit_result, <<-JS
        function(res){
          this.lastCommitResult = res;
          this.fireEvent('submitsuccess', res);
        }
      JS

      endpoint :server_apply_settings do |settings|
        persistence_storage.merge!(settings)
        {:set_result => true}
      end

      # Returns the hash
      def persistence_storage
        owner.component_session[:default_config] ||= {}
        owner.component_session[:default_config]
      end

      # Get the owner component, walking up the parent chain until we find the component with the specified owner class
      def owner
        return @owner unless @owner.nil? # memoization
        @owner = parent
        until @owner.nil? || @owner.class.name == config[:owner_class] do
          @owner = @owner.parent
        end
        @owner
      end
    end
  end
end
