emailNode = $(".email:contains(<%= j @employee.email %>)")
if emailNode.length > 0
  emailNode.next().text("<%= j @employee.roles_in_words %>")
else
  $('#employee_list').append(
    "<%= j render_as_local :employee %>"
  )

$('#new_employment_form').replaceWith(
  "<%= j render_as_local :employment_form %>"
)
