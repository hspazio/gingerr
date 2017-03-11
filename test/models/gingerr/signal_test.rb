require 'test_helper'
require 'minitest/mock'

module Gingerr
  class SignalTest < ActiveSupport::TestCase
    test 'returns STI class for provided type' do
      assert_equal 'Gingerr::SuccessSignal', Gingerr::Signal.class_for_type(:success)
      assert_equal 'Gingerr::ErrorSignal', Gingerr::Signal.class_for_type(:error)
    end

    test 'type attribute not valid if nil' do
      signal = build(:success_signal, type: nil)
      signal.valid?
      assert_not_empty signal.errors[:type]
    end

    test 'type attribute not valid if not supported' do
      signal = build(:success_signal, type: 'UnknownType')
      signal.valid?
      assert_not_empty signal.errors[:type]
    end

    test 'type attribute valid if ErrorSignal' do
      signal = build(:error_signal)
      signal.valid?
      assert_empty signal.errors[:type]
    end

    test 'PID attribute not valid if nil' do
      signal = build(:error_signal, pid: nil)
      signal.valid?
      assert_not_empty signal.errors[:pid]
    end

    test 'PID not valid if string' do
      signal = build(:success_signal, pid: '')
      signal.valid?
      assert_not_empty signal.errors[:pid]
    end

    test 'PID not valid if zero' do
      signal = build(:success_signal, pid: 0)
      signal.valid?
      assert_not_empty signal.errors[:pid]
    end

    test 'PID valid if numeric non zero' do
      signal = build(:error_signal, pid: 123)
      signal.valid?
      assert_empty signal.errors[:pid]
    end

    test 'not valid if not belonging to an app' do
      signal = build(:success_signal, app: nil)
      signal.valid?
      assert_not_empty signal.errors[:app]
    end

    test 'not valid if not belonging to an endpoint' do
      signal = build(:error_signal, endpoint: nil)
      signal.valid?
      assert_not_empty signal.errors[:endpoint]
    end

    test 'responds to app_name' do
      signal = build(:success_signal, app: build(:app, name: 'test app'))
      assert_equal 'test app', signal.app_name
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
      endpoint = build(:endpoint, ip: '123.123.123.123', login: 'login', hostname: 'hostname')
      signal = build(:success_signal, endpoint: endpoint)
      assert_equal 'login@hostname (123.123.123.123)', signal.endpoint_description
    end

    test 'triggers caching of app stats when new signal is created' do
      app = create(:app, stability_score: 23, signal_frequency: 123456)
      create(:success_signal, app: app)

      assert_not_equal 23, app.stability_score
      assert_not_equal 123456, app.signal_frequency
    end
  end
end
