module DashboardsHelper

  def statistic_miltichart(statistic = nil)
    content_tag('div', '<svg></svg>'.html_safe,
                {id: dom_id(statistic),
                 class: 'stat with-3d-shadow with-transitions',
                 data: {json_path: statistic_path(statistic, format: 'json')}})
  end

  def statistic_bar(statistic = nil)
    content_tag('div', '<svg></svg>'.html_safe,
                {id: dom_id(statistic),
                 class: 'stat with-3d-shadow with-transitions', style: 'height: 350px',
                 data: {json_path: statistic_path(statistic, format: 'json', chart_type: 'bar'), chart_type: 'bar'}})
  end
end