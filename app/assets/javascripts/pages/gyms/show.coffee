$(document).on 'page:update', ->
  $('.sections').on 'click', 'a', ->
    sectionsList = $(this).closest('.sections')
    sectionsList.find('a').removeClass('active')
    $(this).addClass('active')
    $(this).blur()
    unless isMediumScreen()
      sectionsList.slideUp ->
        $('.change-section').show()

  $('.gyms.show').on 'click', '.change-section', ->
    $(this).hide ->
      $(this).closest('.gym-info').find('.sections').slideDown()

  $('.gyms.show').on 'click', 'button.gym-details', ->
    $('#current_section').fadeOut ->
      $('#current_section').remove()
      $('.histograms').show()

$(window).resize ->
  if isMediumScreen()
    $('.change-section').hide()
    $('.sections').show()
  else
    if $('.sections').has('.active').length > 0
      $('.change-section').show()
      $('.sections').hide()
