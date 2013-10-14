class GImageCategory < ActiveRecord::Base
  #new picture add by rake_task. From Ctrl can't create category
  attr_accessible :name
  has_many :g_images, dependent: :destroy

  has_many :watching_categories, dependent: :destroy
  has_many :users, through: :watching_categories

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { in: 2..60 }
  validates :updated_at,
            presence: true

  paginates_per 5
end
