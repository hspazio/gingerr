module Gingerr
  class App < ApplicationRecord
    PERCENT_OVERTIME = 1.1

    has_many :signals
    has_many :recent_signals, -> { recent(10) }, class_name: 'Gingerr::Signal'

    validates :name, presence: true

    def current_signal_state
      current_signal && current_signal.state
    end

    def current_signal_created_at
      current_signal && current_signal.created_at
    end

    def current_signal
      @current_signal ||= recent_signals.take
    end

    def signal_frequency
      signals = recent_signals
      if (count_signals = signals.count)
        (signals.first.created_at - signals.last.created_at).to_f / count_signals
      end
    end

    def signal_frequency_in_hours
      "#{(signal_frequency / 3600)} sig/h"
    end

    def require_alert?
      current_signal.success? && signal_frequency * PERCENT_OVERTIME < Time.zone.now - current_signal_created_at
    end
  end
end
