class AddUserCommentsCountToGImages < ActiveRecord::Migration
  def change
    add_column :g_images, :user_comments_count, :integer, default: 0
  end
end
