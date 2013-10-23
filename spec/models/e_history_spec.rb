require 'spec_helper'

describe EHistory do
  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :date }
    it { should allow_mass_assignment_of :event_id }
    it { should allow_mass_assignment_of :eventable }
    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :user_id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:date).of_type(:datetime) }
    it { should have_db_column(:eventable_type).of_type(:string) }
    it { should have_db_column(:eventable_id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:event_id).of_type(:integer) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
    it { should belong_to(:eventable) }
  end

  describe "validations" do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id).only_integer }
    it { should validate_presence_of(:event_id) }
    it { should validate_numericality_of(:event_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      e_hist = FactoryGirl.build(:e_history)
      e_hist.save.should be_true
      EHistory.last.should eql(e_hist)
    end
    it "invalid object" do
      e_hist = FactoryGirl.build(:e_history, user: nil)
      e_hist.save.should be_false
      lambda {e_hist.save!}.should raise_error
    end
  end

end
