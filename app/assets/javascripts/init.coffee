window.Metanoia ||= {}

Metanoia.init = ->
  console.log('')

$(document).on 'page:change', ->
  Metanoia.init()
