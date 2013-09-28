class CreateGImageCategories < ActiveRecord::Migration
  def change
    create_table :g_image_categories do |t|
      t.string :name, null: false
    end
  end
end
