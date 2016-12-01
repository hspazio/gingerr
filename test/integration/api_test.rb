require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  def assert_valid_app(data)
    assert data[:id] > 0
    assert_not_empty data[:name]
    assert_not_empty data[:created_at]
    assert_not_empty data[:updated_at]
  end

  def assert_valid_signal(data)
    assert data[:id] > 0
    assert_match(/success|error/, data[:type])
    assert data[:pid] > 0
    assert_not_empty data[:app]
    assert_not_empty data[:endpoint]
    assert_not_empty data[:created_at]
  end

  def assert_not_found
    data = parse_json(response.body)

    assert_response :not_found
    assert_equal 'Record not found', data[:errors].first
  end

  test 'GET /apps shows all available apps' do
    get '/gingerr/apps.json'

    app_list = parse_json(response.body)

    assert_response :success
    assert_not_empty app_list
    app_list.each { |app| assert_valid_app(app) }
  end

  test 'GET /apps/:id shows an app' do
    app = gingerr_apps(:app_monkey)
    get "/gingerr/apps/#{app.id}.json"

    data = parse_json(response.body)

    assert_response :success
    assert_valid_app(data)
  end

  test 'GET /apps/:id shows 404 status if app not found' do
    get '/gingerr/apps/99999.json'

    assert_not_found
  end

  test 'GET /apps/:app_id/signals shows signals related to app' do
    app = gingerr_apps(:app_monkey)
    get "/gingerr/apps/#{app.id}/signals.json"

    signal_list = parse_json(response.body)

    assert_response :success
    signal_list.each { |signal| assert_valid_signal(signal) }
  end

  test 'GET /apps/:app_id/signals shows 404 status if app not found' do
    get '/gingerr/apps/99999/signals.json'

    assert_not_found
  end

  test 'GET /signals/:id shows a single signal' do
    signal = gingerr_signals(:signal_monkey_1)
    get "/gingerr/signals/#{signal.id}.json"

    data = parse_json(response.body)

    assert_response :success
    assert_valid_signal(data)
  end

  test 'GET /signals/:id shows 404 status if signal not found' do
    get '/gingerr/signals/99999.json'

    assert_not_found
  end

  test 'POST /apps/:app_id/signals creates a success signal' do
    app = gingerr_apps(:app_monkey)
    params = {
        type: 'success',
        pid: 123,
        ip: '123.123.123.123',
        hostname: 'MyHostName',
        login: 'name_surname' }
    post "/gingerr/apps/#{app.id}/signals.json", params: params

    data = parse_json(response.body)

    assert_response :created
    assert data[:id] > 0
    assert_not_empty response.headers[:Location]
  end
end
