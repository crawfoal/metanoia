$(document).on 'page:update', ->
  $('#current_section').on 'click', '.new-climb-link', ->
    $(this).closest('#current_section').find('#climbs').slideUp()
