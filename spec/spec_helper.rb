# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'fakeweb'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

FakeWeb.allow_net_connect = false

page_body = <<-end_of_page
      <!DOCTYPE html>
      <html>
        <head><title>Example Page Number 1!</title></head>
        <body>A web page.</body>
      </html>
end_of_page

reddit_body = page_body.sub(/Ex.+1!/, 'reddit: the front page of the internet')
page2_body  = page_body.sub(/Ex.+1!/, 'Example Page Number 2!')
root_page_body = page_body.sub(/Ex.+1/, 'Example')

FakeWeb.register_uri(:any, 'http://example.com/page1', body: page_body)
FakeWeb.register_uri(:any, 'http://example.com/page2', body: page2_body)
FakeWeb.register_uri(:any, 'http://example.com', body: root_page_body)
FakeWeb.register_uri(:any, 'http://www.reddit.com', body: reddit_body)
FakeWeb.register_uri(:any, 'http://www.reddit.com/r/ruby', body: reddit_body)
FakeWeb.register_uri(:any, 'http://example.com/will_redirect_to_page1',
                     status: ['301', 'Permanently moved'],
                     location: 'http://example.com/page1')

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, follow_redirects: false)
end

RSpec.configure do |config|
  # Include FactoryGirl methods in example namespace.
  config.include FactoryGirl::Syntax::Methods

  config.include LoginMacros
  config.include BookmarkMacros

  # Set up DatabaseCleaner
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Devise::TestHelpers, type: :controller

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
