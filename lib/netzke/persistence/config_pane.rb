module Netzke
  module Persistence
    module ConfigPane
      # Get the owner component, walking up the parent chain until we find the component with the specified owner class
      def owner
        return @owner unless @owner.nil? # memoization
        @owner = parent
        until @owner.nil? || @owner.class.name == config[:owner_class] do
          @owner = @owner.parent
        end
        @owner
      end
    end
  end
end