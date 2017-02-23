module Gingerr
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session, if: proc { |c| c.request.format.to_s == 'application/json' }

    def dashboard
      @apps = Gingerr::App.listing
      @project_health = Gingerr::Stats::AppsStateSummary.new.call
      @recent_errors = Gingerr::Stats::RecentErrors.new.call
      @signals = Gingerr::Signal.recent.includes(:app, :endpoint)
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
