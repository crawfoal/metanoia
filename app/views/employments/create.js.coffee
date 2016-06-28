$('main').before("<%= escape_javascript(render_flash) %>")

<% if @employment_form.valid? %>
$('.employments.index > table').append(
  "<%= escape_javascript(render(partial: '/employments/table_row', locals: { employment: @employment_form.to_model })) %>"
)
$('#employment_email').val('')
$('#employment_role_name').val('')
<% end %>
