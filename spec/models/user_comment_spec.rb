require 'spec_helper'

describe UserComment do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :text }
    it { expect(subject).to allow_mass_assignment_of :g_image }
    it { expect(subject).to allow_mass_assignment_of :g_image_id }
    it { expect(subject).not_to allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:text).of_type(:text)}
    it { expect(subject).to have_db_column(:g_image_id).of_type(:integer) }
  end

  describe "associations" do
    it { expect(subject).to have_one(:e_history).dependent(:destroy) }
    it { expect(subject).to belong_to(:g_image).counter_cache }
    it { expect(subject).to have_one(:user).through(:e_history) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:text) }
    it { expect(subject).to ensure_length_of(:text).is_at_least(2).is_at_most(250)  }
    it { expect(subject).to validate_presence_of(:g_image_id) }
    it { expect(subject).to validate_numericality_of(:g_image_id).only_integer }
  end

  describe "saving into db" do
    it "valid object" do
      comment = FactoryGirl.build(:user_comment)
      expect(comment.save).to be_true
      expect(UserComment.last).to eql(comment)
    end
    it "invalid object" do
      comment = FactoryGirl.build(:user_comment, text: nil)
      expect(comment.save).to be_false
      expect {comment.save!}.to raise_error
    end
  end

  describe "parameters" do
    let!(:comments) { FactoryGirl.create_list(:user_comment, 15) }

    it "comments per page" do
      UserComment.page(1).size.should eq 5
    end
  end

end
