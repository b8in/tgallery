require 'spec_helper'

describe Like do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :g_image }
    it { should allow_mass_assignment_of :g_image_id }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:g_image_id).of_type(:integer) }
  end

  describe "associations" do
    it { should have_one(:e_history).dependent(:destroy) }
    it { should belong_to(:g_image).counter_cache }
  end

  describe "validations" do
    it { should validate_presence_of(:g_image_id) }
    it { should validate_numericality_of(:g_image_id).only_integer  }
  end

end
