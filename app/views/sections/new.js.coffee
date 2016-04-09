gymSections = $('form#new_gym fieldset#gym_sections')
sectionFields = gymSections.find('fieldset.section-fields')
numSections = sectionFields.length
newSectionFields = "<%= escape_javascript(render 'new_section_fields') %>".replace(/child_index_for_new_section/g, numSections.toString())
sectionFields.last().after(newSectionFields)
