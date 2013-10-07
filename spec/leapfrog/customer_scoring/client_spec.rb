require 'spec_helper'

describe Leapfrog::CustomerScoring do
  describe "#initialize" do
    it "should have the correct default url" do
      client = Leapfrog::CustomerScoring::Client.new
      default_url = "http://internal.leapfrogonline.com/customer_scoring"
      expect(client.send(:url)).to eql(default_url)
    end

    it "should allow another url to be specified" do
      custom_url = "http://paulnsorensen.com"
      client = Leapfrog::CustomerScoring::Client.new(custom_url)
      expect(client.send(:url)).to eql(custom_url)
    end
  end

  describe "#get_score" do
    context "when successful" do
      before(:all) do
        test_url =  Leapfrog::CustomerScoring::Client::DEFAULT_URL
        test_url += "?age=35&income=50000&zipcode=60621"
        stub_request(:get, test_url).
        to_return(status: 200, body: '{"propensity": 0.26532,"ranking": "C"}')
        client = Leapfrog::CustomerScoring::Client.new
        @result = client.get_score("50000", "60621", "35")
      end

      it "should return a Hash" do
        expect(@result).to be_kind_of(Hash)
      end

      it "should only include 'propensity' and 'ranking" do
        expect(@result.keys.sort).to eql([:propensity, :ranking])
      end

      it "should have the correct value for 'propensity'" do
        expect(@result[:propensity]).to eql(0.26532)
      end

      it "should have the correct value for 'ranking'" do        
        expect(@result[:ranking]).to eql("C")
      end
    end

    context "when invalid url" do
      before(:all) do
        test_url =  Leapfrog::CustomerScoring::Client::DEFAULT_URL
        test_url += "?age=35&income=50000&zipcode=60621"
        stub_request(:get, test_url).
        to_return(status: [404, "Invalid URL"])
      end
      let(:client) { Leapfrog::CustomerScoring::Client.new }

      it "should raise an ResourceNotFound exception" do
        expect { client.get_score("50000", "60621", "35") }.
        to raise_error(Leapfrog::CustomerScoring::ResourceNotFound)
      end
    end

    context "when invalid input" do
      before(:all) do
        test_url =  Leapfrog::CustomerScoring::Client::DEFAULT_URL
        test_url += "?age=35&income=50000&zipcode=no"
        stub_request(:get, test_url).
        to_return(status: [422, "Invalid Input"])
      end
      let(:client) { Leapfrog::CustomerScoring::Client.new }

      it "should raise an InvalidInput exception" do
        expect { client.get_score("50000", "no", "35") }.
        to raise_error(Leapfrog::CustomerScoring::InvalidInput)
      end
    end

    context "when server error" do
      before(:all) do
        test_url =  Leapfrog::CustomerScoring::Client::DEFAULT_URL
        test_url += "?age=35&income=50000&zipcode=60621"
        stub_request(:get, test_url).
        to_return(status: [500, "Internal Server Error"])
      end
      let(:client) { Leapfrog::CustomerScoring::Client.new }

      it "should raise a ServerError exception" do
        expect { client.get_score("50000", "60621", "35") }.
        to raise_error(Leapfrog::CustomerScoring::ServerError)
      end
    end

    context "when timed out" do
      before(:all) do
        test_url =  Leapfrog::CustomerScoring::Client::DEFAULT_URL
        test_url += "?age=35&income=50000&zipcode=60621"
        stub_request(:get, test_url).
        to_timeout
      end
      let(:client) { Leapfrog::CustomerScoring::Client.new }

      it "should raise a ServerTimeout exception" do
        expect { client.get_score("50000", "60621", "35") }.
        to raise_error(Leapfrog::CustomerScoring::ServerTimeout)
      end
    end
  end
end