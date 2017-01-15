module Gingerr
  class App < ApplicationRecord
    has_many :signals, -> { order('created_at DESC, id DESC') }

    validates :name, presence: true

    scope :listing, -> { includes(:signals).order(:name) }

    def recent_signals(limit = 10)
      signals.limit(limit)
    end

    def count_recent_signals
      recent_signals.count
    end

    def count_recent_success_signals
      recent_signals.count { |signal| signal.state == :success }
    end

    def current_signal_state
      current_signal && current_signal.state
    end

    def current_signal_created_at
      current_signal && current_signal.created_at
    end

    def current_signal
      @current_signal ||= recent_signals.take
    end

    # TODO: move these 2 methods into AppStats class
    def signal_frequency
      signals = recent_signals
      if (count_signals = signals.count)
        (signals.first.created_at - signals.last.created_at).to_f / count_signals
      end
    end

    def signal_frequency_in_hours
      "#{(signal_frequency / 3600)} sig/h"
    end

    def stats
      @stats ||= Gingerr::AppStats.new(self)
    end

    def require_alert?(signal_frequency)
      current_signal.success? && current_signal.overtime?(signal_frequency)
    end
  end
end
