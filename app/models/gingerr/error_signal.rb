module Gingerr
  class ErrorSignal < Gingerr::Signal
    has_one :error, foreign_key: 'signal_id'

    def error?
      true
    end

    def success?
      false
    end
  end
end