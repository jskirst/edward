ruby '2.4.3'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
# Use: Application framework
# URL: https://github.com/rails/rails

gem 'turbolinks', '~> 5.0'
# Use: Speed page load via client side asset caching
# URL: https://github.com/turbolinks/turbolinks

gem 'pg', '~> 0.21'
# Use: Ruby adapter for Postgresql
# URL: https://github.com/ged/ruby-pg

gem 'puma', '~> 3.7'
# Use: Webserver
# URL: https://github.com/puma/puma

gem 'rails-rapido', '~> 0.3'
# Use: Rails application controller framework
# URL: https://github.com/starfighterheavy/rapido

gem 'rack-cors', '~> 1.0', require: 'rack/cors'
# Use: Rack Middleware for handling Cross-Origin Resource Sharing (CORS)
# URL: https://github.com/cyu/rack-cors

gem 'httparty', '~> 0.15'
# Use: Rest API client library
# URL: https://github.com/jnunemaker/httparty

gem 'liquid', '~> 4.0'
# Use: Safe interpolation of user provided values
# URL: https://github.com/Shopify/liquid

gem 'jsonpath', '~> 0.8'
# Use: Traversing JSON object paths
# URL: https://github.com/joshbuddy/jsonpath

gem 'kaminari', '~> 1.1'
# Use: Pageination library
# URL: https://github.com/kaminari/kaminari

gem 'devise', '~> 4.3'
# Use: User authentication and registration
# URL: https://github.com/plataformatec/devise

gem 'slim', '~> 3.0'
# Use: Slim template engine for Rails
# URL: https://github.com/slim-template/slim

gem 'simple_form', '~> 3.5'
# Use: View helpers for forms
# URL: https://github.com/plataformatec/simple_form

gem 'sass-rails', '~> 5.0'
# Use: Sass adapter for Rails
# URL: https://github.com/rails/sass-rails

gem 'bootstrap', '4.0.0.beta2.1'
# Use: Asset library for Bootstrap 4
# URL: https://github.com/twbs/bootstrap-rubygem

gem 'dotenv-rails', '~> 2.2'
# Use: Environment variable loader
# URL: https://github.com/bkeepers/dotenv

group :test do
  gem 'capybara', '~> 2.16.0'
  # Use: Test driver
  # URL: https://github.com/teamcapybara/capybara

  gem 'cucumber-api-steps', '~> 0.14'
  # Use: Cucumber step definition library for testing APIs
  # URL: https://github.com/jayzes/cucumber-api-steps

  gem 'cucumber-rails', '~> 1.5', require: false
  # Use: Cucumber adapter for Rails
  # URL: https://github.com/cucumber/cucumber-rails

  gem 'cucumber-sammies', '~> 0.1'
  # Use: Cucumber step definitions for web application testing
  # URL: https://github.com/starfighterheavy/cucumber-sammies

  gem 'database_cleaner', '~> 1.6'
  # Use: Test database cleaner
  # URL: https://github.com/DatabaseCleaner/database_cleaner

  gem 'rspec-rails', '~> 3.7'
  # Use: Rspec adapter for Rails
  # URL: https://github.com/rspec/rspec

  gem 'simplecov', '~> 0.15'
  # Use: Code coverage analyzer
  # URL: https://github.com/colszowka/simplecov

  gem 'simplecov-console', '~> 0.4'
  # Use: Console output formatter for Simplecov results
  # URL: https://github.com/chetan/simplecov-console

  gem 'webmock', '~> 3.1'
  # Use: External resource mocking for integration testing
  # URL: https://github.com/bblimke/webmock
end

group :development, :test do
  gem 'pry-byebug'
  # Use: Debugging plugin for Pry
  # URL: https://github.com/deivid-rodriguez/pry-byebug

  gem 'cucumber-persona', '~> 0.2'
  # Use: Test data population
  # URL: https://github.com/starfighterheavy/cucumber-persona
end
