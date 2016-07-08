gymSections = $('form#new_gym_form fieldset#gym_sections')
sectionFields = gymSections.find('fieldset.section-fields')
numSections = sectionFields.length
newSectionFields =
  "<%= escape_javascript(render 'new_section_fields') %>".replace(
    /child_index_for_new_section/g,
    numSections.toString()
  )
$('#add_new_section').before(newSectionFields)
