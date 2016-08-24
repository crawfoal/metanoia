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
    employment_form = build :employment_form
    allow(employment_form.employment).to receive(:valid?).and_return(false)

    expect(employment_form).to_not be_valid
  end

  it 'is invalid if a user cannot be found with the given email' do
    employment_form = build :employment_form, :with_unregistered_email

    expect(employment_form).to_not be_valid
  end

  it 'is invalid if the role name is not in `Employment.list`' do
    employment_form = build :employment_form, role_name: 'fake'

    expect(employment_form).to_not be_valid
  end

  it 'is invalid without a role name' do
    employment_form = build :employment_form, role_name: nil

    expect(employment_form).to_not be_valid
  end

  describe '#initialize' do
    it 'instantiates an employment object' do
      employment_form = EmploymentForm.new

      expect(employment_form.employment).to be_a Employment
    end

    it 'gives left over attributes to Employment.new' do
      employment_form = EmploymentForm.new(gym_id: 1)

      expect(employment_form.employment.gym_id).to eq 1
    end
  end

  describe '#persist!' do
    it 'determines which role_story shoud be associated with the employment' do
      user = create :setter
      employment_form = build :employment_form, user: user

      expect { employment_form.persist! }.to \
        change { employment_form.employment.role_story }.from(nil).
        to(user.setter_story)
    end

    it "creates a role story for the user if they don't have the role yet" do
      setter = create :setter
      ef = build :employment_form, user: setter, role_name: 'manager'

      expect { ef.persist! }.to change { setter.reload.manager_story }.from(nil)
    end

    it 'actually saves the employment record in the database' do
      setter = create :setter
      employment_form = build :employment_form, user: setter

      employment_form.persist!

      db_record = setter.setter_story.employments.first
      in_memory = employment_form.employment
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
      ) # no gym specified
      ef.valid?

      expect(ef.errors).to be_present
    end
  end

  describe '#valid?' do
    it 'returns true if the object was initialized with valid data, even if '\
       'persist! has not been called yet' do
      ef = build :employment

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
