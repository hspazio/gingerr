require 'test_helper'

module Gingerr
  class AppsTest < IntegrationTest
    setup do
      @env = http_basic_auth!('admin', 'admin')
    end

    test 'should show app' do
      app = gingerr_apps(:app_monkey)
      get "/gingerr/apps/#{app.id}", env: @env

      assert_response :success
    end
  end
end
