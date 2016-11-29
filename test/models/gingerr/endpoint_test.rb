require 'test_helper'

module Gingerr
  class EndpointTest < TestCase
    setup do
      @endpoint = Gingerr::Endpoint.new
    end

    test 'ip attribute not valid if nil' do
      @endpoint.ip = nil
      assert_any_errors @endpoint, :ip
    end

    test 'ip attribute not valid if empty' do
      @endpoint.ip = ''
      assert_any_errors @endpoint, :ip
    end

    test 'ip attribute not valid if not IPv4 format' do
      @endpoint.ip = '1.hello.1.x'
      assert_any_errors @endpoint, :ip

      @endpoint.ip = '1.144.555.666'
      assert_any_errors @endpoint, :ip
    end

    test 'ip attribute valid if IPv4 format' do
      @endpoint.ip = '1.2.3.255'
      assert_no_errors @endpoint, :ip
    end

    test 'hostname attribute not valid if nil' do
      @endpoint.hostname = nil
      assert_any_errors @endpoint, :hostname
    end

    test 'hostname attribute not valid if empty' do
      @endpoint.hostname = ''
      assert_any_errors @endpoint, :hostname
    end

    test 'hostname attribute valid if present' do
      @endpoint.hostname = 'my-host-name'
      assert_no_errors @endpoint, :hostname
    end

    test 'login attribute not valid if nil' do
      @endpoint.login = nil
      assert_any_errors @endpoint, :login
    end

    test 'login attribute not valid if empty' do
      @endpoint.login = ''
      assert_any_errors @endpoint, :login
    end

    test 'login attribute valid if present' do
      @endpoint.login = 'my_login'
      assert_no_errors @endpoint, :login
    end
  end
end
