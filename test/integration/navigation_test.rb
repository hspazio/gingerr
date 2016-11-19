require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'should display dashboard' do
    get '/gingerr'
    assert_response :success
  end
end

