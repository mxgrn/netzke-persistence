class ComponentWithPersistence < Netzke::Base
  config :default, {
    :persistence => true,
    :title => "Default title"
  }

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
    update_persistent_options(:title => "New title") # this way :title will get merged into config
    {}
  end

  endpoint :set_original_title do |params|
    update_persistent_options(:title => nil) # setting to nil means removing the key, so the default value be used
    {}
  end
end
