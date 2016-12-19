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
        login: 'name_surname'
      }
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
        login: 'name_surname'
      }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::Signal, signal
      assert_not_empty @creator.errors
      assert_not signal.endpoint.valid?
    end

    test 'creates an error signal given an app and parameters' do
      app = gingerr_apps(:app_monkey)
      params = {
        type: 'error',
        pid: 123,
        ip: '123.123.123.123',
        hostname: 'MyHostName',
        login: 'name_surname',
        error: {
          name: 'StandarError',
          message: 'something bad happened',
          file: 'file.rb',
          backtrace: "some long\nmultiline backtrace"
        }
      }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::ErrorSignal, signal
      assert_empty @creator.errors
      assert signal.endpoint
    end

    test 'fails creating an error signal if invalid params' do
      app = gingerr_apps(:app_monkey)
      params = {
        type: 'error',
        pid: 123,
        ip: '123.123.123.123',
        hostname: 'MyHostName',
        login: 'name_surname',
        error: {
          name: '',
          message: 'something bad happened',
          file: 'file.rb',
          backtrace: nil
        }
      }
      signal = @creator.create(app, params)

      assert_kind_of Gingerr::ErrorSignal, signal
      assert_equal ["Name can't be blank", "Backtrace can't be blank"], @creator.errors
    end
  end
end
