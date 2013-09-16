require 'spec_helper'

describe Navigation do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :target_url }
    it { should_not allow_mass_assignment_of :id }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:target_url).of_type(:string) }
  end

  describe "associations" do
    it { should have_one(:e_history).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:target_url) }
  end

end
