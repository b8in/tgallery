class CreateWatchingCategories < ActiveRecord::Migration
  def change
    create_table :watching_categories do |t|
      t.integer :user_id, null: false
      t.integer :g_image_category_id, null: false
      t.datetime :created_at
    end
  end
end
