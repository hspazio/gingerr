module Gingerr
  class Signal < ApplicationRecord
    belongs_to :app
    belongs_to :endpoint

    validates :type, inclusion: ['SuccessSignal', 'ErrorSignal']
    validates :pid, numericality: { only_integer: true, greater_than: 0 }

    scope :recent, ->(limit=10) { order('created_at DESC').limit(limit) }

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
