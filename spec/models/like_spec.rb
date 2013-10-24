require 'spec_helper'

describe Like do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :g_image }
    it { expect(subject).to allow_mass_assignment_of :g_image_id }
    it { expect(subject).not_to allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:g_image_id).of_type(:integer) }
  end

  describe "associations" do
    it { expect(subject).to have_one(:e_history).dependent(:destroy) }
    it { expect(subject).to belong_to(:g_image).counter_cache }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:g_image_id) }
    it { expect(subject).to validate_numericality_of(:g_image_id).only_integer  }
  end

  describe "saving into db" do
    it "valid object" do
      like = FactoryGirl.build(:like)
      expect(like.save).to be_true
      expect(Like.last).to eql(like)
    end
    it "invalid object" do
      like = FactoryGirl.build(:like, g_image: nil)
      expect(like.save).to be_false
      expect {like.save!}.to raise_error
    end
  end

end
