require 'test_helper'

module Gingerr
  class AppTest < ActiveSupport::TestCase
    test 'name attribute not valid if nil' do
      app = build(:app, name: nil)
      app.valid?
      assert_not_empty app.errors[:name]
    end

    test 'name attribute not valid if empty' do
      app = build(:app, name: '')
      app.valid?
      assert_not_empty app.errors[:name]
    end

    test 'type attribute valid if not empty' do
      app = build(:app, name: 'example app')
      app.valid?
      assert_empty app.errors[:name]
    end

    test 'has recent signals' do
      app = create(:app)
      signals = create_list(:success_signal, 3, app: app)

      assert_equal signals[1..-1].reverse, app.recent_signals(2)
    end

    test 'has current signal' do
      app = create(:app)
      signals = create_list(:success_signal, 2, app: app)

      assert_equal signals.last, app.current_signal
    end

    test 'responds to current_signal_state' do
      app = create(:app)
      create_list(:success_signal, 2, app: app)
      assert_equal :success, app.current_signal_state
    end

    test 'responds to current_signal_created_at' do
      app = create(:app)
      signal = create(:success_signal, app: app)
      assert_equal signal.created_at, app.current_signal_created_at
    end

    test 'calculate approximate signal frequency' do
      app = build(:app, signal_frequency: 10_000)
      assert_equal '2 sig/h', app.signal_frequency_in_hours

      app.signal_frequency = 20_000
      assert_equal '5 sig/h', app.signal_frequency_in_hours
    end

    test '#stability_level is :ok if 100% stability score' do
      app = build(:app, stability_score: 100)
      assert_equal :ok, app.stability_level
    end

    test '#stability_level is :unstable if stability score not high enough' do
      app = build(:app, stability_score: 71)
      assert_equal :unstable, app.stability_level

      app = build(:app, stability_score: 99)
      assert_equal :unstable, app.stability_level
    end

    test '#stability_level is :critical if stability score is low' do
      app = build(:app, stability_score: 20)
      assert_equal :critical, app.stability_level

      app = build(:app, stability_score: 0)
      assert_equal :critical, app.stability_level

      app = build(:app, stability_score: 70)
      assert_equal :critical, app.stability_level
    end
  end
end
