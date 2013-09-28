class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :g_image_id
      t.integer :e_history_id
    end
  end
end
