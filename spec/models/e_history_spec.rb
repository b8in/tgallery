require 'spec_helper'

describe EHistory do
  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :date }
    it { expect(subject).to allow_mass_assignment_of :event_id }
    it { expect(subject).to allow_mass_assignment_of :eventable }
    it { expect(subject).not_to allow_mass_assignment_of :id }
    it { expect(subject).not_to allow_mass_assignment_of :user_id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:date).of_type(:datetime) }
    it { expect(subject).to have_db_column(:eventable_type).of_type(:string) }
    it { expect(subject).to have_db_column(:eventable_id).of_type(:integer) }
    it { expect(subject).to have_db_column(:user_id).of_type(:integer) }
    it { expect(subject).to have_db_column(:event_id).of_type(:integer) }
  end

  describe "associations" do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:event) }
    it { expect(subject).to belong_to(:eventable) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:date) }
    it { expect(subject).to validate_presence_of(:user_id) }
    it { expect(subject).to validate_numericality_of(:user_id).only_integer }
    it { expect(subject).to validate_presence_of(:event_id) }
    it { expect(subject).to validate_numericality_of(:event_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      e_hist = FactoryGirl.build(:e_history)
      expect(e_hist.save).to be_true
      expect(EHistory.last).to eql(e_hist)
    end
    it "invalid object" do
      e_hist = FactoryGirl.build(:e_history, user: nil)
      expect(e_hist.save).to be_false
      expect {e_hist.save!}.to raise_error
    end
  end

end
