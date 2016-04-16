$(document).on 'page:update', ->
  $('[class^="flash"]').on 'click', 'button.close', ->
    $(this).closest('[class^="flash"]').slideUp()
