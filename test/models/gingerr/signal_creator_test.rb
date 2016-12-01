require 'test_helper'

module Gingerr
  class SignalCreatorTest < TestCase
    setup do
      @creator = Gingerr::SignalCreator.new
    end

    test 'creates a success signal given an app and parameters' do
      app = gingerr_apps(:app_monkey)
      params = {
          type: 'success',
          pid: 123,
          ip: '123.123.123.123',
          hostname: 'MyHostName',
          login: 'name_surname' }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::Signal, signal
      assert_empty signal.errors
      assert signal.endpoint
    end

    test 'fails creating success signal if pid not valid' do
      app = gingerr_apps(:app_monkey)
      params = {
          type: 'success',
          pid: nil,
          ip: '123.123.123.123',
          hostname: 'MyHostName',
          login: 'name_surname' }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::Signal, signal
      assert_not_empty @creator.errors
      assert signal.endpoint.valid?
    end

    test 'fails creating success signal if invalid endpoint params' do
      app = gingerr_apps(:app_monkey)
      params = {
          type: 'success',
          pid: 123,
          ip: '',
          hostname: 'MyHostName',
          login: 'name_surname' }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::Signal, signal
      assert_not_empty @creator.errors
      assert_not signal.endpoint.valid?
    end
  end
end
