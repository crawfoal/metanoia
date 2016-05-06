$(document).on 'page:change', ->
  $('.gym').first().show()
  $('.section:first-of-type').show()

  sectionPaginator = new Metanoia.Paginator('.section')

  $('.section').on 'click', '> h3 > .fa-caret-right', ->
    sectionPaginator.nextPage()

  $('.section').on 'click', '> h3 > .fa-caret-left', ->
    sectionPaginator.prevPage()

  gymPaginator = new Metanoia.Paginator('.gym')

  $('.gym').on 'click', '> h2 > .fa-caret-right', ->
    gymPaginator.nextPage()

  $('.gym').on 'click', '> h2 > .fa-caret-left', ->
    gymPaginator.prevPage()
