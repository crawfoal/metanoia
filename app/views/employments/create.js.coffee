$('main').before("<%= escape_javascript(render_flash) %>")

<% if @employment_form.valid? %>
$('.employments.index > table').append(
  "<%= escape_javascript(render(partial: '/employments/employee', locals: { employee: @employee })) %>"
)
$('#employment_email').val('')
$('#employment_role_name').val('')
<% end %>
