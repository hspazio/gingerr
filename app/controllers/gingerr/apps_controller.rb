module Gingerr
  class AppsController < Gingerr::ApplicationController
    def show
      @app = Gingerr::App.find_by(id: params[:id])
      @signals = @app.recent_signals
    end
  end
end