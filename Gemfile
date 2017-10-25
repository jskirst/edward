ruby '2.3.4'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'dotenv-rails'
gem 'cucumber-persona'
gem 'rack-cors', require: 'rack/cors'
gem 'httparty'
gem 'liquid'
gem 'jsonpath'
gem 'rails-rapido'
gem 'kaminari'

group :test do
  gem 'capybara', '~> 2.13.0'
  gem 'cucumber-api-steps', github: 'jayzes/cucumber-api-steps'
  gem 'cucumber-rails', require: false
  gem 'cucumber_factory'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'spreewald'
  gem 'webmock'
end

group :development, :test do
  gem 'pry-byebug'
end
