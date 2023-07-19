# typed: ignore
# frozen_string_literal: true

unless ENV['NO_COVERAGE']
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  SimpleCov.add_group 'Interactors', 'app/interactors'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'database_cleaner-active_record'
require 'database_cleaner_support'
require 'session_helper'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

module ActiveSupport
  class TestCase
    extend T::Sig
    include DatabaseCleanerSupport
    extend Shoulda::Matchers::ActiveModel
    extend Shoulda::Matchers::ActiveRecord

    fixtures :all
  end
end

module ActionController
  class TestCase
    extend T::Sig
    include DatabaseCleanerSupport
    extend Shoulda::Matchers::ActionController

    fixtures :all
  end
end

module ActionDispatch
  class IntegrationTest
    extend T::Sig
    include DatabaseCleanerSupport
    extend Shoulda::Matchers::ActionController

    fixtures :all
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
