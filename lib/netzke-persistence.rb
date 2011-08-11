require 'netzke/persistence'

# Make components auto-loadable
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)

module Netzke
  module Persistence
    class Engine < ::Rails::Engine
    end
  end
end
