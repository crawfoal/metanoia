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

  $('select#user_current_role').on 'change', ->
    $(this).closest('form').submit()

  $('#switch_roles').on 'click', 'a', (event)->
    event.preventDefault()
    unless isMediumScreen()
      $(this).closest('#switch_roles').find('form').slideToggle()

$(window).resize ->
  navbarResize()
