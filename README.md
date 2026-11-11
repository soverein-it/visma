# Visma

This is a Ruby on Rails [Engine](http://guides.rubyonrails.org/engines.html) for integrating with [Visma Global](https://www.visma.no/programvare/okonomi/visma-global/overview/)

## Usage

Use Ubuntu. :) To be able to install the tiny_tds gem, you need:

    apt install freetds-dev

In your Gemfile:

    gem 'visma', '~> 0.6', git: "https://github.com/soverein-it/visma"

Set up the database connection in `config/database.yml`

    development:
      visma:
        adapter: sqlserver
        host: sqlserver.your.domain
        database: YourBusinessASGlobalData
        username: sa
        password: YourSuperSecret
        timeout: 15000

Then in `config/visma.yml`, define required variables:

    # Visma table prefix
    table_name_prefix: YourBusiness.
    # The Customer number employees are Chain members of
    employee_chain_number: 49999
    # The CustomerProfileNo used for factoring
    factoring_customer_profile_number: 101
    # The FormProfileNo used for factoring
    factoring_form_profile_number: 506
    # The RemittanceProfileNo used for factoring
    factoring_remittance_profile_number: 6

## Dependencies

The v0.7 series of this gem depends on rails 8 (8.0.5.2 or 8.1.4.1 and newer) and the activerecord-sqlserver-adapter 8 series. Use v0.6 for rails 6.

We are only supporting Microsoft SQL Server 2012 and newer.

If you want SQL Server 2008 support, you need an older version of this gem.

## Development

The tests and the dummy app in `test/dummy` run against SQL Server in Docker:

    docker compose up -d --wait
    bundle exec rake visma:db:prepare
    bundle exec rake test

`visma:db:prepare` creates `visma_development` and `visma_test` and loads `db/visma_schema.rb` into the `KuraasAS` schema.

# License

See MIT-LICENSE
