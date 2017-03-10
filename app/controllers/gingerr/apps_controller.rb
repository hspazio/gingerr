module Gingerr
  class AppsController < Gingerr::ApplicationController
    def index
      @apps = Gingerr::App.all

      respond_to do |format|
        format.json { render json: @apps, root: true }
      end
    end

    def show
      if (@app = Gingerr::App.find_by(id: params[:id]))
        respond_to do |format|
          format.json { render json: @app }
          format.html do
            @signals = @app.recent_signals
            app_errors = Gingerr::Error.by_app(@app)
            @recent_errors = Gingerr::Stats::RecentErrors.new(app_errors).call
          end
        end
      else
        not_found
      end
    end
  end
end
