module Gingerr
  class AppsController < Gingerr::ApplicationController
    def index
      @apps = Gingerr::App.all

      respond_to do |format|
        format.json { render json: @apps, root: true }
      end
    end

    def show
      @app = Gingerr::App.find_by(id: params[:id])

      if @app
        respond_to do |format|
          format.json { render json: @app }
          format.html { @signals = @app.recent_signals }
        end
      else
        not_found
      end
    end
  end
end