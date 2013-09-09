class CreateGImages < ActiveRecord::Migration
  def change
    create_table :g_images do |t|
      t.string :name
      t.string :image
      t.integer :g_image_category_id
    end
  end
end
