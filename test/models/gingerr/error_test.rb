require 'test_helper'

module Gingerr
  class ErrorTest < TestCase
    setup do
      @error = Gingerr::Error.new
    end

    test 'name is invalid if not present' do
      @error.name = nil
      assert_any_errors(@error, :name)

      @error.name = ''
      assert_any_errors(@error, :name)
    end

    test 'name is valid if present' do
      @error.name = 'StandardError'
      assert_no_errors(@error, :name)
    end

    test 'message is invalid if not present' do
      @error.message = nil
      assert_any_errors(@error, :message)

      @error.message = ''
      assert_any_errors(@error, :message)
    end

    test 'message is valid if present' do
      @error.message = 'some error occurred'
      assert_no_errors(@error, :message)
    end

    test 'file is invalid if not present' do
      @error.file = nil
      assert_any_errors(@error, :file)

      @error.file = ''
      assert_any_errors(@error, :file)
    end

    test 'file is valid if present' do
      @error.file = 'my_file.rb'
      assert_no_errors(@error, :file)
    end

    test 'backtrace is invalid if not present' do
      @error.backtrace = nil
      assert_any_errors(@error, :backtrace)

      @error.backtrace = ''
      assert_any_errors(@error, :backtrace)
    end

    test 'backtrace is valid if present' do
      @error.backtrace = 'backtrace here'
      assert_no_errors(@error, :backtrace)
    end
  end
end

