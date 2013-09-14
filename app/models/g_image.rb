class GImage < ActiveRecord::Base
  attr_accessible :name, :image
  belongs_to :g_image_category, touch: true
  has_many :likes, dependent: :destroy
  has_many :user_comments, dependent: :destroy

  mount_uploader :image, ImageUploader
  paginates_per 5

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: true}
  validates :image,
            presence: true
  validates :likes_count,
            presence: true,
            numericality: { only_integer: true}
  validates :user_comments_count,
            presence: true,
            numericality: { only_integer: true}
end
