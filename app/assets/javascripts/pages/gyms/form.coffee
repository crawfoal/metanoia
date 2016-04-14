$(document).on 'page:change', ->
  $('#gym_sections').on 'click', '.remove-section', (event) ->
    event.preventDefault()
    sectionFields = $(this).closest('.section-fields')
    sectionFields.find('[type="hidden"]').val(true)
    sectionFields.hide()
