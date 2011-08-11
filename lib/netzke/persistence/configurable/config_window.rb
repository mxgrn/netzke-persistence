module Netzke
  module Persistence
    module Configurable
      class ConfigWindow < Netzke::Basepack::Window
        js_mixin :config_window

        action :ok
        action :cancel

        js_property :buttons, [:ok.action, :cancel.action]

        endpoint :submit_settings do |params|
          success = true
          {:set_result => success}
        end
      end

    end
  end
end
