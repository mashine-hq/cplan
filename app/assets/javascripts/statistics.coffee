show_charts = () ->
  $('.stat').each () ->
    if $(this).data('chartType') == 'bar'
      line_bar(this)
    else
      show_milti_chart(this)

show_milti_chart = (element) ->
  json_path = $(element).data('jsonPath')
  graph_div = $(element).attr('id')
  target_svg = '#' + graph_div + ' svg'
  d3.json json_path, (data) ->
    #console.log 'chart_'+ graph_div
    nv.addGraph ->
      chart = nv.models.stackedAreaChart().margin({top: 60, right: 40, bottom: 30, left: 30}).x((d) ->
        d[0]
      ).y((d) ->
        d[1]
      ).rightAlignYAxis(true).clipEdge(true).showControls(false).useInteractiveGuideline(true)#.focusEnable(true)
      #Format x-axis labels with custom function.
      chart.xAxis.tickFormat (d) ->
        d3.time.format('%x') new Date(d)
      chart.yAxis.tickFormat d3.format(',.1f')
      d3.select(target_svg).datum(data).transition().duration(500).call chart
      nv.utils.windowResize chart.update
      chart
    return

line_bar = (element) ->
  json_path = $(element).data('jsonPath')
  graph_div = $(element).attr('id')
  target_svg = '#' + graph_div + ' svg'
  d3.json json_path, (data) ->
    data = data.map (series) ->
     series.values = series.values.map((d) -> { x: d[0], y: d[1]})
     series
    #linePlusBarChart
    nv.addGraph ->
      chart = nv.models.linePlusBarChart().margin(top: 60, right: 40, bottom: 30, left: 50
      ).legendLeftAxisHint(' [слева]').legendRightAxisHint(' [справа]').color(d3.scale.category10().range())
      chart.xAxis.tickFormat((d) ->
        d3.time.format('%x') new Date(d)
      ).showMaxMin false
      chart.y2Axis.tickFormat (d) ->
        d3.format(',f')(d)
      chart.bars.forceY([ 0 ]).padData false
      chart.x2Axis.tickFormat((d) ->
        d3.time.format('%x') new Date(d)
      ).showMaxMin false
      d3.select(target_svg).datum(data).transition().duration(500).call chart
      nv.utils.windowResize chart.update
      #chart.dispatch.on 'stateChange', (e) ->
      #  nv.log 'New State:', JSON.stringify(e)
      chart
      return

show_charts()
