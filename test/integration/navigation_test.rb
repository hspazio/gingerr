require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'should display dashboard' do
    get '/gingerr'
    assert_response :success
  end

  test 'should display signal page' do
    signal = gingerr_signals(:signal_monkey_1)
    get "/gingerr/signals/#{signal.id}"

    assert_response :success
  end

  test 'should display all errors page' do
    get '/gingerr/errors'
    assert_response :success
  end
end

