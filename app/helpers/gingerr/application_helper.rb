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

    def app_stability_score(app_stats)
      score = app_stats.stability_score
      score_color = case score
                    when 1 then 'text-success'
                    when (0..0.7) then 'text-danger'
                    when (0.7..1) then 'text-warning'
                    end
      content_tag :strong, class: "stability-score #{score_color}" do
        "#{(score * 100).round}%" 
      end
    end
  end
end
