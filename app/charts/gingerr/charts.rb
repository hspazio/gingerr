module Gingerr
  module Charts
    COLORS = {
      orange: '#f0c75e',
      green:  '#89b94b',
      red:    '#e08f5d'
    }.freeze

    class DistanceBetweenSignals
      SAMPLE_SIZE = 50

      def initialize(app, view)
        @app = app
        @view = view
      end

      def render
        data = @app.distance_between_signals(SAMPLE_SIZE)
        @view.area_chart(data, options)
      end

      def options
        { library: { colors: [COLORS[:orange]] } }
      end
    end
  end
end
