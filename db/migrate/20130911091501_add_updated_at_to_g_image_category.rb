class AddUpdatedAtToGImageCategory < ActiveRecord::Migration
  def change
    add_column :g_image_categories, :updated_at, :datetime, default: Time.now
  end
end
