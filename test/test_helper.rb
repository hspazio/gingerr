require 'simplecov'
SimpleCov.start
require 'mocha/mini_test'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [
  File.expand_path("../../test/dummy/db/migrate", __FILE__)
]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end

def parse_json(data)
  JSON.parse(data, symbolize_names: true)
end

module Gingerr
  class TestCase < ActiveSupport::TestCase
    def assert_any_errors(object, attribute)
      object.valid?
      assert_not_empty object.errors[attribute]
    end

    def assert_no_errors(object, attribute)
      object.valid?
      assert_empty object.errors[attribute]
    end
  end
end
