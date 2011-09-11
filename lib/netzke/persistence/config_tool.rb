module Netzke
  module Persistence
    # This is a plugin that displays the "gear" tool and loads 'config_window', when the "configurable" option is set to true
    class ConfigTool < Netzke::Base
      js_base_class "Ext.Component"

      js_method :init, <<-JS
        function(cmp){
          this.parent = cmp;

          if (!cmp.tools) cmp.tools = [];

          // show the config tool?
          if (cmp.mode && cmp.mode.config || cmp.configurable) {
            cmp.tools.push({type: 'gear', handler: this.onGear, scope: this});
          }
        }
      JS

      js_method :on_gear, <<-JS
        function(){
          if (this.configWindow) {
            this.configWindow.show();
          } else {
            this.parent.loadNetzkeComponent({name: 'config_window', callback: function(w){
              w.show();
              this.configWindow = w;
            }, scope: this});
          }
        }
      JS
    end
  end
end