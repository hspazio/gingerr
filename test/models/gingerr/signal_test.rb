require 'test_helper'

module Gingerr
  class SignalTest < ActiveSupport::TestCase
    setup do
      @signal = Gingerr::Signal.new
    end

    test 'type attribute not valid if nil' do
      @signal.type = nil
      @signal.valid?
      assert_not_empty @signal.errors[:type]
    end

    test 'type attribute not valid if not supported' do
      @signal.type = 'UnknownType'
      @signal.valid?
      assert_not_empty @signal.errors[:type]
    end

    test 'type attribute valid if SuccessSignal' do
      @signal.type = 'SuccessSignal'
      @signal.valid?
      assert_empty @signal.errors[:type]
    end

    test 'PID attribute not valid if nil' do
      @signal.pid = nil
      @signal.valid?
      assert_not_empty @signal.errors[:pid]
    end

    test 'PID not valid if string' do
      @signal.pid = ''
      @signal.valid?
      assert_not_empty @signal.errors[:pid]
    end

    test 'PID not valid if zero' do
      @signal.pid = 0
      @signal.valid?
      assert_not_empty @signal.errors[:pid]
    end

    test 'PID valid if numeric non zero' do
      @signal.pid = 123
      @signal.valid?
      assert_empty @signal.errors[:pid]
    end

    test 'not valid if not belonging to an app' do
      @signal.app = nil
      @signal.valid?
      assert_not_empty @signal.errors[:app]
    end

    test 'valid if belongs to app' do
      @signal.app = Gingerr::App.new(name: 'test')
      @signal.valid?
      assert_empty @signal.errors[:app]
    end

    test 'responds to app_name' do
      @signal.app = Gingerr::App.new(name: 'test')
      assert_equal 'test', @signal.app_name
    end

    test 'returns true to ErrorSignal#error?' do
      assert_equal true, ErrorSignal.new.error?
    end

    test 'returns false to SuccessSignal#error?' do
      assert_equal false, SuccessSignal.new.error?
    end

    test 'responds to state' do
      assert_equal :error, ErrorSignal.new.state
      assert_equal :success, SuccessSignal.new.state
    end
  end
end