navbarResize = ->
  if isMediumScreen()
    $('#navbar_menu_button').hide()
    $('#collapsable_content').show()
  else
    $('#navbar_menu_button').show()
    $('#collapsable_content').hide()

$(document).on 'page:change', ->
  navbarResize()

  $('nav').on 'click', '#navbar_menu_button', ->
    $('#collapsable_content').slideToggle()

$(window).resize ->
  navbarResize()
