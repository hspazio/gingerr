require 'test_helper'

module Gingerr
  class StatsTest < ActiveSupport::TestCase
    test 'Stats::AppsStateSummary should get breakdown of the state of each app' do
      Gingerr::App.any_instance.stubs(stability_level: :ok, stability_score: 0)
      project_health = Gingerr::Stats::AppsStateSummary.new(App.all)
      data = project_health.call

      expected_data = [
        [:ok, 3],
        [:unstable, 0],
        [:critical, 0]
      ]

      assert_equal expected_data, data
    end
  end
end
