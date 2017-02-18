require 'test_helper'

module Gingerr
  class ErrorInfoTest < ActiveSupport::TestCase
    test 'decorates an error object' do
      error = Gingerr::Error.new(
        name: 'the-error',
        message: 'the-message',
        file: 'the-file',
      )
      first_seen_date = Date.new(2017, 3, 25)
      last_seen_date  = Date.new(2017, 4, 11)
      Gingerr::Error.stubs(:first_seen_by_name).with('the-error').returns(first_seen_date)
      Gingerr::Error.stubs(:last_seen_by_name).with('the-error').returns(last_seen_date)
      Gingerr::Error.stubs(:count_by_name).with('the-error').returns(17)
      error_info = ErrorInfo.new(error)
      assert_equal 'the-error', error_info.name
      assert_equal 'the-message', error_info.message
      assert_equal 'the-file', error_info.file
      assert_equal first_seen_date, error_info.first_seen
      assert_equal last_seen_date, error_info.last_seen
      assert_equal 17, error_info.occurrences
    end
  end
end
