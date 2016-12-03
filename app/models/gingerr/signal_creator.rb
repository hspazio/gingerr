module Gingerr
  class SignalCreator
    attr_reader :errors

    def initialize
      @errors = []
    end

    def create(app, params)
      Signal.transaction do
        endpoint = Endpoint.where(endpoint_params(params)).first_or_create
        @errors += endpoint.errors.full_messages unless endpoint.persisted?

        signal = app.signals.create(signal_params(params).merge(endpoint: endpoint))
        @errors += signal.errors.full_messages unless signal.persisted?

        if signal.respond_to?(:error?) && signal.error?
          error = signal.create_error(error_params(params))
          @errors += error.errors.full_messages unless error.persisted?
        end

        signal
      end
    end

    private

    def endpoint_params(params)
      params.slice(:ip, :hostname, :login)
    end

    def signal_params(params)
      { pid: params[:pid],
        type: Signal.class_for_type(params[:type]) }
    end

    def error_params(params)
      params[:error]
    end
  end
end