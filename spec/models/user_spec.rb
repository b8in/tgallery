require 'spec_helper'

describe User do

  describe 'mass assignment attributes' do
    it { expect(subject).to allow_mass_assignment_of :name }
    it { expect(subject).to allow_mass_assignment_of :email }
    it { expect(subject).to allow_mass_assignment_of :password }
    it { expect(subject).to allow_mass_assignment_of :password_confirmation }
    it { expect(subject).to allow_mass_assignment_of :remember_me }
    it { expect(subject).to allow_mass_assignment_of :admin }
    it { expect(subject).to allow_mass_assignment_of :current_password }
    it { expect(subject).not_to allow_mass_assignment_of :id }
    it { expect(subject).not_to allow_mass_assignment_of :created_at }
    it { expect(subject).not_to allow_mass_assignment_of :updated_at }
    it { expect(subject).not_to allow_mass_assignment_of :encrypted_password }
  end

  describe "data types" do
    it { expect(subject).to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { expect(subject).to have_db_column(:email).of_type(:string).with_options(null: false, uniq: true) }
    it { expect(subject).to have_db_column(:name).of_type(:string) }
    it { expect(subject).to have_db_column(:admin).of_type(:boolean).with_options(null: false, default: false) }
    it { expect(subject).to have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_column(:reset_password_token).of_type(:string) }
    it { expect(subject).to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:remember_created_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0) }
    it { expect(subject).to have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:current_sign_in_ip).of_type(:string) }
    it { expect(subject).to have_db_column(:last_sign_in_ip).of_type(:string) }
    it { expect(subject).to have_db_column(:created_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "associations" do
    it { expect(subject).to have_many(:services).dependent(:destroy) }
    it { expect(subject).to have_many(:e_histories).dependent(:destroy) }
    it { expect(subject).to have_many(:user_comments).dependent(:destroy).through(:e_histories) }
    it { expect(subject).to have_many(:likes).dependent(:destroy).through(:e_histories) }
    it { expect(subject).to have_many(:events).through(:e_histories) }
    it { expect(subject).to have_many(:watching_categories).dependent(:destroy) }
    it { expect(subject).to have_many(:g_image_categories).through(:watching_categories) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(subject).to validate_presence_of(:name) }
  end

  describe "valid and invalid attributes" do
    it { expect(subject).to allow_value(true).for(:admin) }
    it { expect(subject).to allow_value(false).for(:admin) }
    it { expect(subject).not_to allow_value(nil).for(:admin) }
    it { expect(subject).to allow_value("usa@mail.com").for(:email) }
    it { expect(subject).not_to allow_value("@mail.com").for(:email) }
    it { expect(subject).not_to allow_value(" @mail.com").for(:email) }
    it { expect(subject).not_to allow_value("usa@mail,x").for(:email) }
    it { expect(subject).not_to allow_value("usa@ma il.com").for(:email) }
  end

  describe "saving into db" do
    it "valid object" do
      user = FactoryGirl.build(:user)
      expect(user.save).to be_true
      expect(User.last).to eql(user)
    end
    it "invalid object" do
      user = FactoryGirl.build(:user, email: nil)
      expect(user.save).to be_false
      expect {user.save!}.to raise_error
    end
  end

end
