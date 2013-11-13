require 'spec_helper'

describe Navigation do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :target_url }
    it { expect(subject).not_to allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:target_url).of_type(:string) }
  end

  describe "associations" do
    it { expect(subject).to have_one(:e_history).dependent(:destroy) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:target_url) }
  end

  describe "saving into db" do
    it "valid object" do
      nav = FactoryGirl.build(:navigation)
      expect(nav.save).to be_true
      expect(Navigation.last).to eql(nav)
    end
    it "invalid object" do
      nav = FactoryGirl.build(:navigation, target_url: nil)
      expect(nav.save).to be_false
      expect {nav.save!}.to raise_error
    end
  end

end
