class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :admin, :current_password

  has_many :services, dependent: :destroy
  has_many :e_histories, dependent: :destroy
  has_many :user_comments, through: :e_histories, source: :eventable, source_type: 'UserComment', dependent: :destroy
  has_many :likes, through: :e_histories, source: :eventable, source_type: 'Like', dependent: :destroy

  has_many :events, through: :e_histories
  has_many :watching_categories, dependent: :destroy
  has_many :g_image_categories, through: :watching_categories

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            email: true
  validates :password,
            presence: true
  validates :password_confirmation,
            presence: true
  validates :name,
#            uniqueness: true,
            presence: true
  validates :admin,
            inclusion: { in: [true, false] }
end
