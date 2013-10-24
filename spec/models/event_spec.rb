require 'spec_helper'

describe Event do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :name }
    it { expect(subject).not_to allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:name).of_type(:string).with_options(null: false, uniq: true) }
  end

  describe "associations" do
    it { expect(subject).to have_many(:e_histories).dependent(:destroy) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(subject).to ensure_length_of(:name).is_at_least(2).is_at_most(60)  }
  end

  describe "valid and invalid objects" do
    it { expect(subject).to allow_value("navigation").for(:name) }
    it { expect(subject).not_to allow_value("x").for(:name) }
  end

  describe "saving into db" do
    it "valid object" do
      event = FactoryGirl.build(:event)
      expect(event.save).to be_true
      expect(Event.last).to eql(event)
    end
    it "invalid object" do
      event = FactoryGirl.build(:event, name: nil)
      expect(event.save).to be_false
      expect {event.save!}.to raise_error
    end
  end

end
