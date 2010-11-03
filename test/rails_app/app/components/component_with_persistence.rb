class ComponentWithPersistence < Netzke::Base
  config :initial, :persistence => true, :title => "Default title"
  
  action :change_title
  action :set_original_title
  
  js_property :bbar, [:change_title.action, :set_original_title.action]

  js_method :on_change_title, <<-JS
    function(){
      this.setNewTitle();
    }
  JS
  
  js_method :on_set_original_title, <<-JS
    function(){
      this.setOriginalTitle();
    }
  JS
  
  endpoint :set_new_title do |params|
    update_persistent_options(:title => "New title")
    {}
  end
  
  endpoint :set_original_title do |params|
    update_persistent_options(:title => nil)
    Rails.logger.debug "!!! persistent_options: #{persistent_options.inspect}\n"
    {}
  end
end
