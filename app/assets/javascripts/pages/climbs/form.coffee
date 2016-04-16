showGradeChoices = (climbType = '') ->
  return unless ($.inArray(climbType, ['Boulder', 'Route']) >= 0)
  gradeDiv = $('.grade')
  gradeDiv.find('select').hide()
  gradeDiv.find('#' + climbType.toLowerCase() + '_grades').show()

$(document).on 'page:update', ->
  climbForm = $('form[id$="_climb"]')

  climbForm.find('#climb_section_id').val(
    $('section#current_section').data('section-id')
  )

  climbForm.find('.climb-type').on 'click', 'span', ->
    showGradeChoices $(this).text()

  climbForm.submit ->
    $(this).find('select[style="display: none;"]').remove()
