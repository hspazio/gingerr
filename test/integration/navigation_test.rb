require 'test_helper'

module Gingerr
  class NavigationTest < IntegrationTest
    setup do
      @env = http_basic_auth!('admin', 'admin')
    end

    test 'displays dashboard' do
      get '/gingerr', env: @env
      assert_response :success
    end

    test 'displays signal page' do
      signal = gingerr_signals(:signal_monkey_1)
      get "/gingerr/signals/#{signal.id}", env: @env

      assert_response :success
    end

    test 'displays all errors page' do
      get '/gingerr/errors', env: @env
      assert_response :success
    end
  end
end
