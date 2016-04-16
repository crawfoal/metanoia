$('#current_section').remove()
currentSectionView =
  "<%= escape_javascript(render 'show', section: @section) %>"
$('.sections').after(currentSectionView)
