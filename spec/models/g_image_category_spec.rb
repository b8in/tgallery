require 'spec_helper'

describe GImageCategory do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :name }
    it { expect(subject).not_to allow_mass_assignment_of :id }
    it { expect(subject).not_to allow_mass_assignment_of :updated_at }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "associations" do
    it { expect(subject).to have_many(:g_images).dependent(:destroy) }
    it { expect(subject).to have_many(:watching_categories).dependent(:destroy) }
    it { expect(subject).to have_many(:users).through(:watching_categories) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(subject).to ensure_length_of(:name).is_at_least(2).is_at_most(60)  }
    it { expect(subject).to validate_presence_of(:updated_at) }
  end

  describe "valid and invalid objects" do
    it { expect(subject).to allow_value("cats").for(:name) }
  end

  describe "saving into db" do
    it "valid object" do
      category = FactoryGirl.build(:g_image_category)
      expect(category.save).to be_true
      expect(GImageCategory.last).to eql(category)
      expect(FactoryGirl.create(:g_image_category)).to be
    end
    it "invalid object" do
      category = FactoryGirl.build(:g_image_category, name: nil)
      expect(category.save).to be_false
      expect {category.save!}.to raise_error
    end
  end

end
