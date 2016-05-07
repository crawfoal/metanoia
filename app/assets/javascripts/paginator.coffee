class Metanoia.Paginator
  constructor: (@pageSelector) ->
    @currentSection = $(@pageSelector).filter(':visible')

  nextPage: ->
    nextSection = @currentSection.next(@pageSelector)
    if nextSection.length > 0
      @currentSection.hide()
      nextSection.show()
      @currentSection = nextSection

  prevPage: ->
    prevSection = @currentSection.prev(@pageSelector)
    if prevSection.length > 0
      @currentSection.hide()
      prevSection.show()
      @currentSection = prevSection
