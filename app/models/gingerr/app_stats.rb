module Gingerr
  class AppStats
    def initialize(app)
      @app = app
    end

    def stability_score
      states = @app.recent_signals(30).map(&:state)
      states.count{ |s| s == :success }.to_f / states.size
    end
  end
end