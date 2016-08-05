module PageObjects
  class EmployeeForm < Base
    def submit_with(attributes)
      self.email = attributes.delete(:email) || attributes.delete('email')
      self.role = attributes.delete(:role) || attributes.delete('role')
      submit
    end

    def email
      find('#employment_form_email').value
    end

    def role
      find('#employment_form_role_name').value
    end

    private

    def email=(value)
      fill_in "Employee's Email", with: value
    end

    def role=(value)
      select value, from: 'Role'
    end

    def submit
      click_on 'Add'
    end

    def form
      find '#new_employment_form'
    end
    alias_method :main_element, :form
  end
end
