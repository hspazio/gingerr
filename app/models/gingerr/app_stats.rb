module Gingerr
  class AppStats
    def initialize(app)
      @app = app
    end

    def stability_score
      states = @app.recent_signals(30).map(&:state)
      states.count { |state| state == :success }.to_f / states.size
    end

    def stability_level
      case stability_score
      when 1 then :ok
      when (0..0.7) then :critical
      when (0.7..1) then :unstable
      end
    end

    def recent_signals_timeline
      data = { error: {}, success: {} }
      signals = @app.signals.limit(50)
      dates = (signals.last.created_at.to_date..signals.first.created_at.to_date).to_a
      dates.each do |date|
        data[:success][date] = 0
        data[:error][date] = 0
      end
      signals.each do |signal|
        data[signal.state][signal.created_at.to_date] += 1
      end
      data.map{ |type, data| {name: type, data: data.to_a} }
    end
  end
end
