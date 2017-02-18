module Gingerr
  class Signal < ApplicationRecord
    PERCENT_OVERTIME = 1.1
    TYPES = {
      error:   'Gingerr::ErrorSignal'.freeze,
      success: 'Gingerr::SuccessSignal'.freeze,
    }.freeze

    belongs_to :app
    belongs_to :endpoint

    validates :type, inclusion: TYPES.values
    validates :pid, numericality: { only_integer: true, greater_than: 0 }

    scope :recent,  ->(limit = 10) { order('created_at DESC').limit(limit) }

    def self.class_for_type(type)
      TYPES[type.to_sym]
    end

    def app_name
      app && app.name
    end

    def state
      error? ? :error : :success
    end

    def error?
      false
    end

    def endpoint_description
      endpoint && endpoint.description
    end

    def overtime?(signal_frequency)
      signal_frequency * PERCENT_OVERTIME < Time.zone.now - created_at
    end
  end
end
