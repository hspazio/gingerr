require 'test_helper'

module Gingerr
  class StatsTest < ActiveSupport::TestCase
    test 'Stats::AppsStateSummary should get breakdown of the state of each app' do
      project_health = Gingerr::Stats::AppsStateSummary.new
      data = project_health.call

      assert_not_empty data
      data.each do |state, count|
        assert_not_empty state
        assert count >= 0
      end
    end
  end
end
