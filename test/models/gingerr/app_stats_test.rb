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
  end
end
