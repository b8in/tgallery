require 'spec_helper'

describe Event do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:name).of_type(:string).with_options(null: false, uniq: true) }
  end

  describe "associations" do
    it { should have_many(:e_histories).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(60)  }
  end

  describe "valid and invalid objects" do
    it { should allow_value("navigation").for(:name) }
    it { should_not allow_value("x").for(:name) }
  end

  describe "saving into db" do
    it "valid object" do
      event = FactoryGirl.build(:event)
      event.save.should be_true
      Event.last.should eql(event)
    end
    it "invalid object" do
      event = FactoryGirl.build(:event, name: nil)
      event.save.should be_false
      lambda {event.save!}.should raise_error
    end
  end

end
