module Netzke
  module Persistence
    module Configurable
      class ConfigWindow < Netzke::Basepack::Window
        js_mixin :config_window
        js_property :height, 400

        action :ok
        action :cancel

        js_property :buttons, [:ok.action, :cancel.action]
      end
    end
  end
end
