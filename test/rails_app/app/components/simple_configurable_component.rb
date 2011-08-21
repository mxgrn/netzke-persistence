class SimpleConfigurableComponent < Netzke::Base
  include Netzke::Persistence::Configurable
  js_property :height, 400
  js_property :collapsible, true

  configurable :with => [{
    :class_name => "Netzke::Persistence::FormConfigPane", :title => "Generic", :items => [:title, :html], :height => 300,
  },{
    :class_name => "Netzke::Persistence::FormConfigPane", :title => "Advanced", :items => [{:name => :collapsed, :attr_type => :boolean}]
  }], :in => :tabs

  # configurable :with => [:generic_settings, :advanced_settings], :in => :tabs
  #
  # component :generic_settings, :class_name => "Netzke::Persistence::FormConfigPane", :title => "Generic", :items => [:title, :html]
  # component :advanced_settings, :class_name => "Netzke::Persistence::FormConfigPane", :title => "Advanced", :items => [{:name => :collapsed, :attr_type => :boolean}]

  def default_config
    super.tap do |c|
      c[:configurable] = true
      c.merge!(component_session[:default_config] || {})
    end
  end
end