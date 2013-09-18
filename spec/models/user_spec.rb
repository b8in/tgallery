require 'spec_helper'

describe User do

  describe 'mass assignment attributes' do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    it { should allow_mass_assignment_of :remember_me }
    it { should_not allow_mass_assignment_of :id }
    it { should_not allow_mass_assignment_of :created_at }
    it { should_not allow_mass_assignment_of :updated_at }
    it { should_not allow_mass_assignment_of :admin }
    it { should_not allow_mass_assignment_of :encrypted_password }
  end

  describe "data types" do
    it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:email).of_type(:string).with_options(null: false, uniq: true) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:admin).of_type(:boolean).with_options(null: false, default: false) }
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:current_sign_in_ip).of_type(:string) }
    it { should have_db_column(:last_sign_in_ip).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "associations" do
    it { should have_many(:e_histories).dependent(:destroy) }
    it { should have_many(:user_comments).dependent(:destroy).through(:e_histories) }
    it { should have_many(:events).through(:e_histories) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:encrypted_password) }
  end

  describe "valid and invalid attributes" do
    it { should allow_value(true).for(:admin) }
    it { should allow_value(false).for(:admin) }
    it { should_not allow_value(nil).for(:admin) }
    it { should allow_value("usa@mail.com").for(:email) }
    it { should_not allow_value("@mail.com").for(:email) }
    it { should_not allow_value(" @mail.com").for(:email) }
    it { should_not allow_value("usa@mail.x").for(:email) }
    it { should_not allow_value("usa@ma il.com").for(:email) }
  end

  describe "saving into db" do
    it "valid object" do
      user = FactoryGirl.build(:user)
      user.save.should be_true
      User.last.should eql(user)
      FactoryGirl.create(:user)
    end
    it "invalid object" do
      user = FactoryGirl.build(:user, email: nil)
      user.save.should be_false
      lambda {user.save!}.should raise_error
    end
  end

end
