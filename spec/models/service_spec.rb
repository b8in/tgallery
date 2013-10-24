require 'spec_helper'

describe Service do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :provider }
    it { expect(subject).to allow_mass_assignment_of :uemail }
    it { expect(subject).to allow_mass_assignment_of :uid }
    it { expect(subject).to allow_mass_assignment_of :uname }
    it { expect(subject).not_to allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:provider).of_type(:string) }
    it { expect(subject).to have_db_column(:uemail).of_type(:string) }
    it { expect(subject).to have_db_column(:uid).of_type(:string) }
    it { expect(subject).to have_db_column(:uname).of_type(:string) }
  end

  describe "associations" do
    it { expect(subject).to belong_to(:user) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:uemail) }
    it { expect(subject).to validate_presence_of(:provider) }
    it { expect(subject).to validate_presence_of(:uid) }
    it { expect(subject).to validate_presence_of(:uname) }

  end

  describe "saving into db" do
    it "valid object" do
      nav = FactoryGirl.build(:service)
      expect(nav.save).to be_true
      expect(Service.last).to eql(nav)
    end
    it "invalid object" do
      nav = FactoryGirl.build(:service, uemail: nil)
      expect(nav.save).to be_false
      expect {nav.save!}.to raise_error
    end
  end

end

