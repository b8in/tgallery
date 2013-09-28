class AddLikesCountToGImage < ActiveRecord::Migration
  def change
    add_column :g_images, :likes_count, :integer, default: 0
  end
end
