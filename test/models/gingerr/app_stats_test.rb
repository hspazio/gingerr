require 'test_helper'

module Gingerr
  class AppStatsTest < ActiveSupport::TestCase
    setup do
      app = gingerr_apps(:app_elephant)
      @stats = Gingerr::AppStats.new(app)
    end

    test 'calculates stability score' do
      app = stub(count_recent_success_signals: 10, count_recent_signals: 20)
      stats = Gingerr::AppStats.new(app)
      assert_equal 0.5, stats.stability_score
    end

    test '#stability_level is :ok if 100% stability score' do
      Gingerr::AppStats.any_instance.stubs(stability_score: 1)
      assert_equal :ok, @stats.stability_level
    end

    test '#stability_level is :unstable if stability score not high enough' do
      Gingerr::AppStats.any_instance.stubs(stability_score: 0.71)
      assert_equal :unstable, @stats.stability_level

      Gingerr::AppStats.any_instance.stubs(stability_score: 0.99)
      assert_equal :unstable, @stats.stability_level
    end

    test '#stability_level is :critical if stability score is low' do
      Gingerr::AppStats.any_instance.stubs(stability_score: 0.2)
      assert_equal :critical, @stats.stability_level

      Gingerr::AppStats.any_instance.stubs(stability_score: 0)
      assert_equal :critical, @stats.stability_level

      Gingerr::AppStats.any_instance.stubs(stability_score: 0.7)
      assert_equal :critical, @stats.stability_level
    end

    test 'shows chart data for recent signals' do
      data = @stats.recent_signals_timeline
      assert_equal :error, data.first[:name]
      assert_equal :success, data.last[:name]
      data.each do |data_record|
        data_record[:data].each do |date, count|
          assert_kind_of Date, date
          assert count >= 0
        end
      end
    end
  end
end
