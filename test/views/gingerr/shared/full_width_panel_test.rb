require 'test_helper'

module Gingerr
  class FullWidthPanelTest < ActionView::TestCase
    test 'displays partial' do
      render layout: 'gingerr/shared/full_width_panel', locals: { title: 'Hello World', icon: 'test' } do
        "hello world!"
      end

      assert_select 'div[class="panel panel-default"]', count: 1
      assert_select 'div[class="panel-heading"]', count: 1
      assert_select 'h3[class="panel-title"]', count: 1, text: 'Hello World'
      assert_select 'i[class="fa fa-test"]', count: 1
      assert_select 'div[class="panel-body"]', count: 1, text: 'hello world!'
    end
  end
end

