# Leapfrog::CustomerScoring

Ruby API client for Leapfrog Online customer scoring

## Installation

Add this line to your application's Gemfile:

    gem 'leapfrog-customer_scoring'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leapfrog-customer_scoring

## Usage

Clients are instantiated with `http://internal.leapfrogonline/customer_scoring` as the default URL. 

    client = Leapfrog::CustomerScoring::Client.new

You may optionally pass a different URL to use.

    client = Leapfrog::CustomerScoring::Client.new("http://example.com")

To retrieve the scoring advice for a customer, you will call the `get_score(income, zipcode, age)` method. The response will be a `Hash` with two symbolized keys containing the `:propensity` and `:ranking` for that customer.

    advice = client.get_score("50000", "60621", "35")
    advice.inspect
    => "{:propensity=>0.26532, :ranking=>\"C\"}"

## Testing

To test this gem, you can checkout the master branch and run the `rake`
in your console.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
