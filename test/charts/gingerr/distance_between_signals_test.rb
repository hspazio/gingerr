require 'test_helper'

module Gingerr
  class DistanceBetweenSignalsTest < ActionView::TestCase
    test 'renders the chart' do
      app = stub(distance_between_signals: "some data")
      view = mock
      chart = Gingerr::Charts::DistanceBetweenSignals.new(app, view)
      chart.stubs(options: "some options")

      view.expects(:area_chart).with("some data", "some options")
      chart.render
    end
  end
end

