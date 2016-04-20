$(document).on 'page:change', ->
  actions = $('.actions')
  actions.find('a').first().addClass('active')
  actions.find('form').first().show()

  actions.on 'click', 'a', (event)->
    event.preventDefault()
    activeLink = actions.find('.active')
    activeLink.closest('li').find('form').hide()
    activeLink.removeClass('active')
    $(this).addClass('active')
    $(this).closest('li').find('form').show()
