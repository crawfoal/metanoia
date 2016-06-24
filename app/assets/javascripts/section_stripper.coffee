class Metanoia.SectionStripper
  constructor: (@resetButton) ->
    @linkTemplate = @resetButton.data('link-template')

  requestTeardown: (climbId) ->
    $.ajax({
      type: 'PATCH',
      url: @linkTemplate.replace(':climb_id', climbId),
      contentType: 'application/json',
      data: JSON.stringify({ id: climbId, climb: { teardown_date: Date() } })
    })

  teardownAll: ->
    climbElements = @resetButton.closest('#current_section').find('#climbs a')
    climbIds = climbElements.map (index, climbElement) ->
      $(climbElement).data('params').climb_log.climb_id
    $.each climbIds, (index, climbId) =>
      @requestTeardown(climbId)
