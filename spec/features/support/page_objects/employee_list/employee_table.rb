module PageObjects
  class EmployeeTable < Base
    def roles_for(employee)
      role_node_for(employee).text
    end

    # ----- Action Methods -----

    # ----- Expectation Methods -----
    def has_employee?(employee, with_roles:)
      match_data = table.text.match(/#{employee.email}#{role_regex(with_roles)}/)
      Array(with_roles).size == if match_data.present?
        match_data.to_a[1..-1].compact.size
      else
        0
      end
    end

    def listed_more_than_once?(employee)
      email_nodes_for(employee).size > 1
    end

    private

    def role_regex(role_names)
      role_names_i = Array(role_names)
      regex = role_names_i.reduce('.*(?:') do |regex, role_name|
        regex + "[, ]+(#{role_name})|"
      end
      return regex[0..-2] + "){#{role_names_i.size}}"
    end

    # ----- Finder Methods -----
    def table
      find '#employee_list'
    end
    alias_method :main_element, :table

    def email_nodes_for(employee)
      table.all('.email', text: employee.email)
    end

    def role_node_for(employee)
      xpath = ".//div[@class='email'][contains(text(), '#{employee.email}')]"\
              "/following-sibling::div[@class='role'][1]"
      table.find(:xpath, xpath)
    end
  end
end
