module Leapfrog
  module CustomerScoring 
    class InvalidInput < Exception
      def initialize(data={})
        @data = data
      end
    end
    
    class ResourceNotFound < Exception
      def initialize(data={})
        @data = data
      end
    end
    
    class ServerError < Exception
      def initialize(data={})
        @data = data
      end
    end

    class ServerTimeout < Exception
      def initialize(data={})
        @data = data
      end
    end
  end
end