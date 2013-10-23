require 'spec_helper'

describe WatchingCategory do
  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :g_image_category_id }
    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :user_id }
    it { should_not allow_mass_assignment_of :created_at }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:g_image_category_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:g_image_category) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id).only_integer }
    it { should validate_presence_of(:g_image_category_id) }
    it { should validate_numericality_of(:g_image_category_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      wc = FactoryGirl.build(:watching_category)
      wc.save.should be_true
      WatchingCategory.last.should eql(wc)
      FactoryGirl.create(:watching_category)
    end
    it "invalid object" do
      wc = FactoryGirl.build(:watching_category, user_id: nil)
      wc.save.should be_false
      lambda {wc.save!}.should raise_error
    end
  end
end
