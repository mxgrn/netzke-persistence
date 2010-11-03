module Netzke
  class PersistenceGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    source_root File.expand_path('../templates', __FILE__)

    # Implement the required interface for Rails::Generators::Migration. (* from activerecord *)
    def self.next_migration_number(dirname) #:nodoc:
      next_migration_number = current_migration_number(dirname) + 1
      if ::ActiveRecord::Base.timestamped_migrations
        [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
      else
        "%.3d" % next_migration_number
      end
    end
    
    def execute
      migration_template 'create_netzke_component_states.rb', 'db/migrate/create_netzke_component_states.rb'
    end
  end
end