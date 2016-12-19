require 'test_helper'

module Gingerr
  class AppStatsTest < ActiveSupport::TestCase
    setup do
      app = gingerr_apps(:app_elephant)
      @stats = Gingerr::AppStats.new(app)
    end

    test 'calculates stability score' do
      assert_equal 0.5, @stats.stability_score
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
