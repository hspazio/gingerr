require 'test_helper'
require 'minitest/mock'

module Gingerr
  class ErrorSignalTest < TestCase
    setup do
      @signal = gingerr_signals(:signal_monkey_1)
    end

    test 'it has an error object collaborator' do
      assert_kind_of Gingerr::Error, @signal.error
    end
  end
end
