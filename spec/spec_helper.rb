require 'webmock/rspec'
require 'leapfrog/customer_scoring'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end