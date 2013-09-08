class Painting < ActiveRecord::Base
  attr_accessible  :name, :image, :g_image_category_id
  belongs_to :g_image_category
  mount_uploader :image, ImageUploader
end
