class CreateNavigations < ActiveRecord::Migration
  def change
    create_table :navigations do |t|
      t.integer :e_history_id
      t.string :target_url
    end
  end
end
