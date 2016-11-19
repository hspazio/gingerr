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
  end
end