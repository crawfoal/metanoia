$('main').before("<%= escape_javascript(render_flash) %>")

<% if @employment.valid? %>
$('.employments.index > table').append(
  "<%= escape_javascript(render(partial: '/employments/table_row', locals: { employment: @employment })) %>"
)
$('#employment_email').val('')
$('#employment_role_name').val('')
<% end %>
