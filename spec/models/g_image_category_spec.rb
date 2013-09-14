require 'spec_helper'

describe GImageCategory do

  describe 'mass assignment attributes' do
    it { should_not allow_mass_assignment_of :name }
    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :updated_at }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "associations" do
    it { should have_many(:g_images).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(60)  }
    it { should validate_presence_of(:updated_at) }
  end

  describe "valid and invalid objects" do
    it { should allow_value("cats").for(:name) }
  end
end
