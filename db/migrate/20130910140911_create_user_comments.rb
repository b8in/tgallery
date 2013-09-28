class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :e_history_id
      t.integer :g_image_id
      t.text :text
    end
  end
end
