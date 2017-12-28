require 'cucumber/rails'
require 'rspec/matchers'
require 'cucumber/api_steps'
require 'cucumber/sammies/step_definitions/form_steps'
require 'cucumber/sammies/step_definitions/navigation_steps'
require 'cucumber/sammies/step_definitions/content_steps'

ActionController::Base.allow_rescue = true
ActiveRecord::Migration.maintain_test_schema!
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation
