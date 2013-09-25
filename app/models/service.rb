class Service < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uemail, :uid, :uname

  validates :uemail,
            presence: true,
            email: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :uname, presence: true
end
