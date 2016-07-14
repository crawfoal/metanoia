$('main').before("<%= j(render_flash) %>")

emailNode = $(".email:contains(<%= j @employee.email %>)")
if emailNode.length > 0
  emailNode.next().text("<%= j @employee.roles %>")
else
  $('#employee_list').append(
    "<%= j render(partial: 'employee', locals: { employee: @employee }) %>"
  )

$('#new_employment_form').replaceWith(
  "<%= escape_javascript(render(partial: 'form', locals: {employment_form: EmploymentForm.new})) %>"
)
