require 'spec_helper'

describe UserComment do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :text }
    it { should allow_mass_assignment_of :g_image }
    it { should allow_mass_assignment_of :g_image_id }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:text).of_type(:text)}
    it { should have_db_column(:g_image_id).of_type(:integer) }
  end

  describe "associations" do
    it { should have_one(:e_history).dependent(:destroy) }
    it { should belong_to(:g_image).counter_cache }
    it { should have_one(:user).through(:e_history) }
  end

  describe "validations" do
    it { should validate_presence_of(:text) }
    it { should ensure_length_of(:text).is_at_least(2).is_at_most(250)  }
    it { should validate_presence_of(:g_image_id) }
    it { should validate_numericality_of(:g_image_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      comment = FactoryGirl.build(:user_comment)
      comment.save.should be_true
      UserComment.last.should eql(comment)
      FactoryGirl.create(:user_comment)
    end
    it "invalid object" do
      comment = FactoryGirl.build(:user_comment, text: nil)
      comment.save.should be_false
      lambda {comment.save!}.should raise_error
    end
  end

end
