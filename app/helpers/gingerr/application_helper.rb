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

    # TODO: ugly code. Refactor
    def app_stability_score(app_stats)
      score = app_stats.stability_score
      stability_level = app_stats.stability_level(score: score)
      score_color = app_stability_level(stability_level)
      content_tag :strong, class: "stability-score text-#{score_color}" do
        "#{(score * 100).round}%"
      end
    end

    def app_stability_level(level)
      {
        ok:       'success',
        critical: 'danger',
        unstable: 'warning'
      }[level]
    end

    def colors
      { orange: '#f0c75e',
        green:  '#89b94b',
        red:    '#e08f5d' }
    end

    def pie_chart_options
      {
        plotOptions: {
          pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
              enabled: false
            },
            showInLegend: true
          }
        }
      }
    end
  end
end
