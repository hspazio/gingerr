require 'test_helper'

module Gingerr
  class AppTest < ActiveSupport::TestCase
    setup do
      @app = Gingerr::App.new
    end

    test 'name attribute not valid if nil' do
      @app.name = nil
      @app.valid?
      assert_not_empty @app.errors[:name]
    end

    test 'name attribute not valid if empty' do
      @app.name = ''
      @app.valid?
      assert_not_empty @app.errors[:name]
    end

    test 'type attribute valid if not empty' do
      @app.name = 'rails app'
      @app.valid?
      assert_empty @app.errors[:name]
    end

    test 'has recent signals' do
      app = gingerr_apps(:app_elephant)
      assert_not_empty app.recent_signals
    end

    test 'has current signal' do
      app = gingerr_apps(:app_elephant)
      assert_respond_to app, :current_signal
    end

    test 'responds to current_signal_state' do
      app = gingerr_apps(:app_elephant)
      assert_includes [:error, :success], app.current_signal_state
    end

    test 'responds to current_signal_created_at' do
      app = gingerr_apps(:app_elephant)
      assert_kind_of Time, app.current_signal_created_at
    end

    test 'calculate signal frequency' do
      app = gingerr_apps(:app_elephant)
      freq = app.signal_frequency_in_hours
      assert_match(/\d+ sig\/h/, freq)
      assert_not_equal '0.0 sig/h', freq
    end

    test '#stability_level is :ok if 100% stability score' do
      app = gingerr_apps(:app_elephant)
      app.stubs(stability_score: 100)
      assert_equal :ok, app.stability_level
    end

    test '#stability_level is :unstable if stability score not high enough' do
      app = gingerr_apps(:app_elephant)
      app.stubs(stability_score: 71)
      assert_equal :unstable, app.stability_level

      app.stubs(stability_score: 99)
      assert_equal :unstable, app.stability_level
    end

    test '#stability_level is :critical if stability score is low' do
      app = gingerr_apps(:app_elephant)
      app.stubs(stability_score: 20)
      assert_equal :critical, app.stability_level

      app.stubs(stability_score: 0)
      assert_equal :critical, app.stability_level

      app.stubs(stability_score: 70)
      assert_equal :critical, app.stability_level
    end
  end
end
