require 'rails_helper'

RSpec.describe EmploymentForm do
  it { should implement_form_interface }

  describe '#initialize' do
    it 'instantiates an employment object' do
      expect(EmploymentForm.new.to_model).to be_a Employment
    end

    it 'gives left over attributes to Employment.new' do
      expect(EmploymentForm.new(gym_id: 1).to_model.gym_id).to eq 1
    end
  end

  describe '#email' do
    it 'returns the email attribute if it exists' do
      employment_form = EmploymentForm.new(email: 'foo@example.com')
      expect(employment_form.email).to eq 'foo@example.com'
    end
  end

  describe '#role_name' do
    it 'returns the role name attribute if it exists' do
      employment_form = EmploymentForm.new(role_name: 'setter')
      expect(employment_form.role_name).to eq 'setter'
    end
  end

  describe '#save' do
    context 'the email and role name are both provided' do
      let(:user) { create :setter }
      let(:employment_form) do
        EmploymentForm.new(email: user.email, role_name: 'setter')
      end

      it 'determines which role_story shoud be associated with the employment' do
        expect { employment_form.save }.to change { employment_form.to_model.role_story }.from(nil).to(user.setter_story)
      end

      it 'returns a truthy value' do
        expect(employment_form.save).to be_truthy
      end

      it 'actually saves the employment record in the database' do
        employment_form.save
        db_record = user.reload.setter_story.employments.first
        in_memory = employment_form.to_model
        expect(db_record).to be_present
        expect(db_record.attributes).to eq in_memory.attributes
      end
    end

    context "email and role name aren't both provided" do
      let(:employment_form) { EmploymentForm.new() }

      it 'it returns a falsey value' do
        expect(employment_form.save).to be_falsey
      end
    end
  end

  describe 'valid?' do
    it "returns false if email and role name aren't both provided" do
      expect(EmploymentForm.new()).to_not be_valid
    end

    it 'returns true if email and role name are both provided' do
      employment_form = EmploymentForm.new(
        email: 'foo@example.com',
        role_name: 'setter'
      )
      expect(employment_form).to be_valid
    end

    it 'returns false if the employment record is invalid' do
      employment_form = EmploymentForm.new(
        email: 'foo@example.com',
        role_name: 'setter'
      )
      allow(employment_form.to_model).to receive(:valid?).and_return(false)
      expect(employment_form).to_not be_valid
    end
  end
end
