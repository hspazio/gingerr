module Gingerr
  class Signal < ApplicationRecord
    TYPES = {
        error:   'Gingerr::ErrorSignal',
        success: 'Gingerr::SuccessSignal',
    }

    belongs_to :app
    belongs_to :endpoint

    validates :type, inclusion: TYPES.values
    validates :pid, numericality: { only_integer: true, greater_than: 0 }

    scope :recent,  ->(limit=10) { order('created_at DESC').limit(limit) }

    def self.class_for_type(type)
      TYPES[type.to_sym]
    end

    def app_name
      app && app.name
    end

    def state
      error? ? :error : :success
    end

    def endpoint_description
      endpoint && endpoint.description
    end
  end
end
