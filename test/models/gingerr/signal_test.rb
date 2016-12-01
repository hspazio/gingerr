require 'test_helper'
require 'minitest/mock'

module Gingerr
  class SignalTest < ActiveSupport::TestCase
    setup do
      @signal = Gingerr::Signal.new
    end

    test 'returns STI class for provided type' do
      assert_equal 'Gingerr::SuccessSignal', @signal.class.class_for_type(:success)
      assert_equal 'Gingerr::ErrorSignal', @signal.class.class_for_type(:error)
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
      @signal.type = 'Gingerr::SuccessSignal'
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

    test 'not valid if not belonging to an endpoint' do
      @signal.endpoint = nil
      @signal.valid?
      assert_not_empty @signal.errors[:endpoint]
    end

    test 'valid if belongs to endpoint' do
      @signal.endpoint = gingerr_endpoints(:endpoint_1)
      @signal.valid?
      assert_empty @signal.errors[:endpoint]
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

    test 'delegates endpoint description to endpoint' do
      signal = gingerr_signals(:signal_monkey_1)
      assert_equal 'fs@forest-server (122.230.1.25)', signal.endpoint_description
    end
  end
end