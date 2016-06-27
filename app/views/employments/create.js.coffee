$('main').before("<%= escape_javascript(render_flash) %>")

<% if @employment.valid? %>
$('.employees.index > table').append(
  "<%= escape_javascript(render(partial: '/employees/table_row', locals: { employment: @employment })) %>"
)
<% end %>
