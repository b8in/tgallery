class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :e_histories, dependent: :destroy
  has_many :user_comments, dependent: :destroy, through: :e_histories

  has_many :events, through: :e_histories

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  #          format: { with: /\A([^@\s]+)@([a-z,0-9]+\.[a-z]{2,})\Z/ }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :admin, inclusion: { in: [true, false] }
end
