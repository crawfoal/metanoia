$('form#new_climb').remove()
sectionId = $('#current_section').data('section-id')
if sectionId
  $('#current_section').remove()
  url = "<%= escape_javascript(section_path(:id)) %>".replace('id', sectionId)
  $.get(url)
