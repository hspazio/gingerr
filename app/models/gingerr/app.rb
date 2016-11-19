module Gingerr
  class App < ApplicationRecord
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
  end
end
