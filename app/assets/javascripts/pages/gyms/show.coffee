$(document).on 'page:update', ->
  $('#current_section').on 'click', '.new-climb-link', ->
    $(this).closest('#current_section').find('#climbs').slideUp()

  $('.sections').on 'click', 'a', ->
    sectionsList = $(this).closest('.sections')
    sectionsList.find('a').removeClass('active')
    $(this).addClass('active')
    unless isMediumScreen()
      sectionsList.slideUp ->
        $('.change-section').show()

  $('.gyms.show').on 'click', '.change-section', ->
    $(this).hide ->
      $(this).closest('.gym-info').find('.sections').slideDown()

$(window).resize ->
  if isMediumScreen()
    $('.change-section').hide()
    $('.sections').show()
  else
    if $('.sections').has('.active').length > 0
      $('.change-section').show()
      $('.sections').hide()
