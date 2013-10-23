require 'spec_helper'

describe Service do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :provider }
    it { should allow_mass_assignment_of :uemail }
    it { should allow_mass_assignment_of :uid }
    it { should allow_mass_assignment_of :uname }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:provider).of_type(:string) }
    it { should have_db_column(:uemail).of_type(:string) }
    it { should have_db_column(:uid).of_type(:string) }
    it { should have_db_column(:uname).of_type(:string) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:uemail) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:uname) }

  end

  describe "saving into db" do
    it "valid object" do
      nav = FactoryGirl.build(:service)
      nav.save.should be_true
      Service.last.should eql(nav)
      FactoryGirl.create(:service)
    end
    it "invalid object" do
      nav = FactoryGirl.build(:service, uemail: nil)
      nav.save.should be_false
      lambda {nav.save!}.should raise_error
    end
  end

end

