module Gingerr
  class SignalsController < Gingerr::ApplicationController
    def show
      @signal = Gingerr::Signal.includes(:app).find_by(id: params[:id])
    end
  end
end