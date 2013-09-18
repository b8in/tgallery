require 'spec_helper'

describe Navigation do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :target_url }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:target_url).of_type(:string) }
  end

  describe "associations" do
    it { should have_one(:e_history).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:target_url) }
  end

  describe "saving into db" do
    it "valid object" do
      nav = FactoryGirl.build(:navigation)
      nav.save.should be_true
      Navigation.last.should eql(nav)
      FactoryGirl.create(:navigation)
    end
    it "invalid object" do
      nav = FactoryGirl.build(:navigation, target_url: nil)
      nav.save.should be_false
      lambda {nav.save!}.should raise_error
    end
  end

end
