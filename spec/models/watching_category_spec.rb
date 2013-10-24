require 'spec_helper'

describe WatchingCategory do
  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :g_image_category_id }
    it { expect(subject).not_to allow_mass_assignment_of :id }
    it { expect(subject).not_to allow_mass_assignment_of :user_id }
    it { expect(subject).not_to allow_mass_assignment_of :created_at }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:user_id).of_type(:integer) }
    it { expect(subject).to have_db_column(:g_image_category_id).of_type(:integer) }
    it { expect(subject).to have_db_column(:created_at).of_type(:datetime) }
  end

  describe "associations" do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:g_image_category) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:user_id) }
    it { expect(subject).to validate_numericality_of(:user_id).only_integer }
    it { expect(subject).to validate_presence_of(:g_image_category_id) }
    it { expect(subject).to validate_numericality_of(:g_image_category_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      wc = FactoryGirl.build(:watching_category)
      expect(wc.save).to be_true
      expect(WatchingCategory.last).to eql(wc)
    end
    it "invalid object" do
      wc = FactoryGirl.build(:watching_category, user_id: nil)
      expect(wc.save).to be_false
      expect {wc.save!}.to raise_error
    end
  end
end
