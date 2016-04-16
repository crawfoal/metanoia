$('.new-climb-link').hide()
newClimbForm = "<%= escape_javascript(render 'form', climb: @climb) %>"
$('#current_section').append(newClimbForm)
