$(document).on 'page:change', ->
  $('#gym_sections').on 'click', '.remove-section', (event) ->
    event.preventDefault()
    $(this).closest('.section-fields').remove()
