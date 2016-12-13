module Gingerr
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def dashboard
      @apps = Gingerr::App.all.includes(:signals).order(:name)
      @signals = Gingerr::Signal.recent.includes(:app)
    end

    def render_errors(errors, status = :bad_request)
      render json: { errors: errors }, status: status
    end

    def not_found
      respond_to do |format|
        format.json { render_errors(['Record not found'], :not_found) }
        format.html {}
      end
    end
  end
end
