class AddFieldCreatedAtToGImages < ActiveRecord::Migration
  def change
    add_column :g_images, :created_at, :datetime
  end
end
