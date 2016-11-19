require 'test_helper'

class AppsTest < ActionDispatch::IntegrationTest
  test 'should show app' do
    app = gingerr_apps(:app_monkey)
    get "/gingerr/apps/#{app.id}"

    assert_response :success
  end
end
