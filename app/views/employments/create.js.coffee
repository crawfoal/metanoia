$('main').before("<%= j(render_flash) %>")

emailNode = $(".email:contains(<%= j @employee.email %>)")
if emailNode.length > 0
  emailNode.next().text("<%= j @employee.roles %>")
else
  $('#employee_list').append(
    "<%= j render(partial: 'employee', locals: { employee: @employee }) %>"
  )

$('#employment_form_email').val('')
$('#employment_form_role_name').val('')
