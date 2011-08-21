module Netzke
  module Persistence
    module Configurable
      extend ActiveSupport::Concern

      module ClassMethods
        # Make any Panel-based component dynamically configurable by adding the "gear" tool, which will trigger a window containing configuration panes specified with the +with+ parameter (e.g. +FormConfigPane+, see below).
        #
        # Configuration panes can be displayed in +TabPanel+ (default) or as accordion panes. This is configured by setting the +in+ parameter to :tabs or :accordion.
        #
        # To enable dynamic configuration on a configurable component, the component shold be configured with +configurable+ option set to true, e.g.:
        #
        #     netzke :grid_panel, :model => "User", :configurable => true
        #
        # The components specified with the +with+ param, should implement the +applySettings+ JS method. There is a FormPanel-based configuration pane +FormConfigPane+ provided by Netzke Persistence. Here's an example of using it:
        #
        #     configurable :with => [{
        #       :class_name => "Netzke::Persistence::FormConfigPane", :title => "Generic", :items => [:title, :html],
        #     },{
        #       :class_name => "Netzke::Persistence::FormConfigPane", :title => "Advanced", :items => [{:name => :collapsed, :attr_type => :boolean}]
        #     }]
        #
        def configurable(config)
          config[:in] ||= :tabs

          items = config[:with].size.times.map{ |i| "panel_#{i}" }.map{ |i| i.to_sym.component }
          components = config[:with].each_with_index.inject({}){ |r,(p,i)| r.merge(:"panel_#{i}" => p.merge(:owner_class => self.name)) }

          # Accordion panes or tabs?
          case config[:in].to_sym
          when :accordion
            component :config_window, {
              :content_type => :accordion,
              :class_name => "Netzke::Persistence::Configurable::ConfigWindow",
              :lazy_loading => true,
              :width => 500,
              :layout => :accordion,
              :layout_config => {:animate => true},
              :items => items,
              :components => components
            }
          when :tabs
            component :config_window, {
              :content_type => :tabs,
              :class_name => "Netzke::Persistence::Configurable::ConfigWindow",
              :lazy_loading => true,
              :width => 500,
              :layout => :fit,
              :border => false,
              :items => [{
                :class_name => "Netzke::Basepack::TabPanel",
                :prevent_header => true,
                :items => items,
                :components => components
              }]
            }
          else
            raise ArgumentError, "The 'in' argument should be set to :tabs (default) or :accordion"
          end

          # Add the "gear" tool
          plugin :config_tool, :class_name => "Netzke::Persistence::ConfigTool"

        end
      end
    end
  end
end