$('#current_section').remove()
currentSectionView =
  "<%= escape_javascript(render 'show', section: @section) %>"
$('.histograms').fadeOut ->
  $('.gym-info').append(currentSectionView)
