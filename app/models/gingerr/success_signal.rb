module Gingerr
  class SuccessSignal < Gingerr::Signal
    def error?
      false
    end

    def success?
      true
    end
  end
end