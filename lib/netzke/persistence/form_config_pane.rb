module Netzke
  module Persistence
    # FormPanel-based reusable config pane.
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

      # Overriding the submit endpoint
      endpoint :server_apply_settings do |settings|
        persistence_storage.merge!(settings)
        {:set_result => true}
      end

      # Returns the hash
      def persistence_storage
        parent.parent.component_session[:default_config] ||= {}
        parent.parent.component_session[:default_config]
      end
    end
  end
end
