module Gingerr
  class ErrorSignal < Gingerr::Signal
    def error?
      true
    end

    def success?
      false
    end
  end
end