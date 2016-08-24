require 'view_helper'

RSpec.describe 'employments/index.html.haml', type: :view do
  context "when the user's current role isn't manager" do
    it "doesn't show the new employee form" do
      gym = create :gym
      setter = create :setter, employed_at: gym
      allow(controller).to receive(:current_user).and_return(setter)
      assign(:employee_list, EmployeeList.new(gym))
      assign(:employment_form, EmploymentForm.new(gym_id: gym.id))

      render
      
      expect(rendered).to include gym.name
      expect(rendered).to_not have_content 'Add New Employee'
      expect(rendered).to_not have_selector '#new_employment_form'
    end
  end
end
