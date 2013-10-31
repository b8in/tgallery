require 'spec_helper'

describe GImage do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :name }
    it { expect(subject).to allow_mass_assignment_of :image }
    it { expect(subject).to allow_mass_assignment_of :g_image_category_id }
    it { expect(subject).to allow_mass_assignment_of :remote_image_url }
    it { expect(subject).not_to allow_mass_assignment_of :id }
    it { expect(subject).not_to allow_mass_assignment_of :likes_count }
    it { expect(subject).not_to allow_mass_assignment_of :user_comments_count }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:name).of_type(:string) }
    it { expect(subject).to have_db_column(:image).of_type(:string) }
    it { expect(subject).to have_db_column(:g_image_category_id).of_type(:integer) }
    it { expect(subject).to have_db_column(:likes_count).of_type(:integer) }
    it { expect(subject).to have_db_column(:user_comments_count).of_type(:integer) }
  end

  describe "associations" do
    it { expect(subject).to have_many(:likes).dependent(:destroy) }
    it { expect(subject).to have_many(:user_comments).dependent(:destroy) }
    it { expect(subject).to belong_to(:g_image_category).touch(true) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_uniqueness_of(:name) }
    it { expect(subject).to validate_presence_of(:likes_count) }
    it { expect(subject).to validate_numericality_of(:likes_count).only_integer }
    it { expect(subject).to validate_presence_of(:user_comments_count) }
    it { expect(subject).to validate_numericality_of(:user_comments_count).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      g_image = FactoryGirl.build(:g_image)
      expect(g_image.save).to be_true
      expect(GImage.last).to eql(g_image)
    end
    it "invalid object" do
      g_image = FactoryGirl.build(:g_image, name: nil)
      expect(g_image.save).to be_false
      expect {g_image.save!}.to raise_error
    end
  end

  describe "parameters" do
    let!(:images) { FactoryGirl.create_list(:g_image, 15) }

    it "comments per page" do
      GImage.page(1).size.should eq 5
    end
  end
end
