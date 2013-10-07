module Leapfrog
  module CustomerScoring
    class Client
      DEFAULT_URL = "http://internal.leapfrogonline.com/customer_scoring"

      def initialize(url="")
        @url = url.empty? ? DEFAULT_URL : url
      end

      def get_score(income, zipcode, age)
        params = {income: income, zipcode: zipcode, age: age}
        begin
          RestClient.get(url, params: params) do |response, request, result|
            case response.code
            when 200
              return ::JSON.parse(response, symbolize_names: true)
            when 422
              raise Leapfrog::CustomerScoring::InvalidInput
            when 404
              raise Leapfrog::CustomerScoring::ResourceNotFound
            when 500
              raise Leapfrog::CustomerScoring::ServerError
            else
              response.return!(request, result)
            end
          end
        rescue RestClient::RequestTimeout
          raise Leapfrog::CustomerScoring::ServerTimeout
        end
      end

      private
      attr_reader :url
    end
  end
end
