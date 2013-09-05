class CreateGImageCategories < ActiveRecord::Migration
  def change
    create_table :g_image_categories do |t|
      t.string :name
    end
  end
end
