module Gingerr
  module ApplicationHelper
    def signal_type(signal)
      if signal.error?
        error_label
      else
        success_label
      end
    end

    def error_label
      content_tag :span, class: 'label label-danger' do
        'Error'
      end
    end

    def success_label
      content_tag :span, class: 'label label-success' do
        'Success'
      end
    end
  end
end
