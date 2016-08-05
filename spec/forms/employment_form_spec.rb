require 'rails_helper'

RSpec.describe EmploymentForm, type: :model do
  let(:role_story_for_valid_ef) do
    user = valid_ef.send(:user)
    user.send("#{user.current_role}_story")
  end
  let(:valid_ef) { build :employment_form }

  it { should validate_presence_of :email }
  it { should validate_presence_of :role_name }

  it 'is invalid if the employment record is invalid' do
    allow(valid_ef.to_model).to receive(:valid?).and_return(false)
    expect(valid_ef).to_not be_valid
  end

  it 'is invalid if a user cannot be found with the given email' do
    expect(build(:employment_form, :with_unregistered_email)).to_not be_valid
  end

  describe '#initialize' do
    it 'instantiates an employment object' do
      expect(EmploymentForm.new.employment).to be_a Employment
    end

    it 'gives left over attributes to Employment.new' do
      expect(EmploymentForm.new(gym_id: 1).employment.gym_id).to eq 1
    end
  end

  describe '#persist!' do
    it 'determines which role_story shoud be associated with the employment' do
      expect { valid_ef.persist! }.to change { valid_ef.employment.role_story }.
        from(nil).to(role_story_for_valid_ef)
    end

    it "creates a role story for the user if they don't have the role yet" do
      setter = create(:setter)
      ef = build :employment_form, user: setter, role_name: 'manager'
      expect { ef.persist! }.to change { setter.reload.manager_story }.from(nil)
    end

    it 'actually saves the employment record in the database' do
      valid_ef.persist!
      db_record = role_story_for_valid_ef.employments.first
      in_memory = valid_ef.employment
      expect(db_record).to be_present
      expect(db_record.id).to eq in_memory.id
    end
  end

  describe '#errors' do
    it 'are present when no user can be found with the given email' do
      ef = build :employment_form, :with_unregistered_email
      ef.valid?
      expect(ef.errors).to be_present
    end

    it 'are present when no email or role name are provided' do
      ef = EmploymentForm.new
      ef.valid?
      expect(ef.errors).to be_present
    end

    it 'are present when the employment record is not valid' do
      ef = EmploymentForm.new(
        role_name: 'setter',
        email: create(:setter).email
      )
      ef.valid?
      expect(ef.errors).to be_present
    end
  end

  describe '#valid?' do
    it 'returns true if the object was initialized with valid data, even if '\
       'persist! has not been called yet' do
      ef = EmploymentForm.new(
        gym_id: create(:gym).id,
        role_name: 'setter',
        email: create(:setter).email
      )
      expect(ef).to be_valid
    end
  end

  describe '#to_employee' do
    it 'returns an Employee object that is initialized using the form info' do
      ef = create :employment_form
      employee = ef.to_employee
      expect(employee.email).to eq ef.email
    end
  end
end
