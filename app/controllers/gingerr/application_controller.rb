module Gingerr
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def dashboard
      @apps = Gingerr::App.all.includes(:signals).order(:name)
      @signals = Gingerr::Signal.recent.includes(:app)
    end
  end
end
