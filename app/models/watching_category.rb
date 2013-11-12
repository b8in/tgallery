class WatchingCategory < ActiveRecord::Base
  attr_accessible :g_image_category_id

  belongs_to :user
  belongs_to :g_image_category

  validates :user_id, presence: true, numericality: { only_integer: true}
  validates :g_image_category_id, presence: true, numericality: { only_integer: true}
end
