require 'spec_helper'

describe GImage do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :image }
    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :g_image_category_id }
    it { should_not allow_mass_assignment_of :likes_count }
    it { should_not allow_mass_assignment_of :user_comments_count }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:image).of_type(:string) }
    it { should have_db_column(:g_image_category_id).of_type(:integer) }
    it { should have_db_column(:likes_count).of_type(:integer) }
    it { should have_db_column(:user_comments_count).of_type(:integer) }
  end

  describe "associations" do
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:user_comments).dependent(:destroy) }
    it { should belong_to(:g_image_category).touch(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:likes_count) }
    it { should validate_numericality_of(:likes_count).only_integer }
    it { should validate_presence_of(:user_comments_count) }
    it { should validate_numericality_of(:user_comments_count).only_integer }
  end

end
