$('form.new_employment_form').replaceWith(
  "<%= escape_javascript(render(partial: 'form', locals: {employment_form: @employment_form})) %>"
)
