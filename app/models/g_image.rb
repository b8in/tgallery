class GImage < ActiveRecord::Base
  attr_accessible :name, :image
  belongs_to :g_image_category

  mount_uploader :image, ImageUploader
  paginates_per 5
end
