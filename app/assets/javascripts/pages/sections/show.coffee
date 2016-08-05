$(document).on 'page:update', ->
  $('.gym-info').on 'click', '#current_section #reset', ->
    stripper = new Metanoia.SectionStripper($(this))
    stripper.teardownAll()
