module Gingerr
  class AppStats
    def initialize(app)
      @app = app
    end

    def stability_score
      @app.count_recent_success_signals.to_f / @app.count_recent_signals
    end

    def stability_level(score: stability_score)
      case score
      when 1 then :ok
      when (0..0.7) then :critical
      when (0.7..1) then :unstable
      end
    end

    def recent_signals_timeline
      stats = { error: {}, success: {} }
      signals = @app.signals.limit(50)
      dates = (signals.last.created_at.to_date..signals.first.created_at.to_date).to_a
      dates.each do |date|
        stats[:success][date] = 0
        stats[:error][date] = 0
      end
      signals.each do |signal|
        stats[signal.state][signal.created_at.to_date] += 1
      end
      stats.map{ |type, data| {name: type, data: data.to_a} }
    end
  end
end
