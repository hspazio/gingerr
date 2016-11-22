module Gingerr
  class Signal < ApplicationRecord
    belongs_to :app

    validates :type, inclusion: ['SuccessSignal', 'ErrorSignal']
    validates :pid, numericality: { only_integer: true, greater_than: 0 }

    scope :recent, ->(limit=10) { order('created_at DESC').limit(limit) }

    def app_name
      app && app.name
    end

    def error?
      self.class == Gingerr::ErrorSignal
    end

    def success?
      !error?
    end

    def state
      error? ? :error : :success
    end
  end
end
