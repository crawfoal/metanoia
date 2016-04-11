$(document).on 'page:change', ->
  menuToggle = $('#navbar_menu_button').unbind()
  $('#navbar-main-menu').removeClass('show')

  menuToggle.on 'click', (event) ->
    event.preventDefault()
    navbarMainMenu = $('#navbar-main-menu')
    navbarMainMenu.slideToggle ->
      if navbarMainMenu.is(':hidden')
        navbarMainMenu.removeAttr('style')
