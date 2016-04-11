$(document).on 'page:change', ->
  $('[class^="flash"]').on 'click', 'button.close', ->
    $(this).closest('[class^="flash"]').slideUp()
