RSpec::Matchers.define :list_employee do |employee, with_roles:|
  match do |employee_table|
    if employee_table.listed_more_than_once?(employee)
      raise "Error: employee #{employee} was listed more than once in the table."
    else
      roles_list = employee_table.roles_for employee
      Array(with_roles).all? { |role_name| roles_list.include? role_name.to_s }
    end
  end

  failure_message do |employee_table|
    "expected \"#{employee_table.text}\" to list employee #{employee} with "\
    "roles #{with_roles.to_sentence}"
  end

  failure_message_when_negated do |employee_table|
    "expected \"#{employee_table.text}\" to not list employee #{employee} with"\
    " roles #{with_roles.to_sentence}"
  end
end
