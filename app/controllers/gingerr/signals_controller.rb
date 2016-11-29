module Gingerr
  class SignalsController < Gingerr::ApplicationController
    def index
      if (app = Gingerr::App.find_by(id: params[:app_id]))
        signals = app.signals

        respond_to do |format|
          format.json { render json: signals }
        end
      else
        not_found
      end
    end

    def show
      if (@signal = Gingerr::Signal.includes(:app).find_by(id: params[:id]))
        respond_to do |format|
          format.json { render json: @signal }
          format.html { }
        end
      else
        not_found
      end
    end
  end
end