module Leapfrog
  module CustomerScoring
    class Client
      DEFAULT_URL = "http://internal.leapfrogonline.com/customer_scoring"

      # You may initialize the Client with any url or just use the default
      # url of "http://internal.leapfrogonline.com/customer_scoring".
      # 
      #   client = Leapfrog::CustomerScoring::Client.new
      #
      # -- OR--
      #
      #   other_url = "http://example.com/customer_scoring"
      #   client = Leapfrog::CustomerScoring::Client.new(other_url)
      #
      # This is the url to which the client will make requests
      def initialize(url=DEFAULT_URL)
        @url = url
      end

      # Makes request to the initialized endpoint to retrieve customer
      # scoring advice. The <tt>income</tt>, <tt>zipcode</tt> and
      # <tt>age</tt> parameters are required. The return value is a
      # <tt>Hash</tt> with keys containing the <tt>:propensity</tt>
      # and <tt>:ranking </tt> for customer with the passed parameters
      #
      #   advice = client.get_score("50000", "60621", "35")
      #   advice.inspect
      #   => "{:propensity=>0.26532, :ranking=>\"C\"}"
      #
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
