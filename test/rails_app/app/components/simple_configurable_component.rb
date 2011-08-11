class SimpleConfigurableComponent < Netzke::Base
  include Netzke::Persistence::Configurable

  configurable :with => [{
    :class_name => "Netzke::Basepack::Panel", :title => "Generic"
  },{
    :class_name => "Netzke::Basepack::Panel", :title => "Advanced"
  }]

  def default_config
    super.tap do |c|
      c[:mode] = {:config => true}
    end
  end
end