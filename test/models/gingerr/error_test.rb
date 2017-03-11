require 'test_helper'

module Gingerr
  class ErrorTest < TestCase
    setup do
      @error = Gingerr::Error.new
    end

    test '.first_seen_by_name' do
      signal = gingerr_signals(:signal_monkey_1)
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 1.day.ago.to_date
      )
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 2.days.ago.to_date
      )

      assert_equal 2.days.ago.to_date, Gingerr::Error.first_seen_by_name('the-error')
    end

    test '.last_seen_by_name' do
      signal = gingerr_signals(:signal_monkey_1)
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 1.day.ago.to_date
      )
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 2.days.ago.to_date
      )

      assert_equal 1.day.ago.to_date, Gingerr::Error.last_seen_by_name('the-error')
    end

    test '.count_by_name' do
      signal = gingerr_signals(:signal_monkey_1)
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 1.day.ago.to_date
      )
      Gingerr::Error.create!(
        signal: signal,
        name: 'the-error', 
        file: 'the-file', 
        message: 'the-message',
        backtrace: 'the-backtrace',
        created_at: 2.days.ago.to_date
      )

      assert_equal 2, Gingerr::Error.count_by_name('the-error')
    end

    test 'name is invalid if not present' do
      error = build(:error, name: nil)
      assert_any_errors(error, :name)

      error.name = ''
      assert_any_errors(error, :name)
    end

    test 'message is invalid if not present' do
      error = build(:error, message: nil)
      assert_any_errors(error, :message)

      error.message = ''
      assert_any_errors(error, :message)
    end

    test 'file is invalid if not present' do
      error = build(:error, file: nil)
      assert_any_errors(error, :file)

      error.file = ''
      assert_any_errors(error, :file)
    end

    test 'backtrace is invalid if not present' do
      error = build(:error, backtrace: nil)
      assert_any_errors(error, :backtrace)

      error.backtrace = ''
      assert_any_errors(error, :backtrace)
    end
  end
end

