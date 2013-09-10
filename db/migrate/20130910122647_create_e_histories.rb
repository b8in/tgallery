class CreateEHistories < ActiveRecord::Migration
  def change
    create_table :e_histories do |t|
      t.integer :user_id
      t.integer :event_id
      t.datetime :date
    end
  end
end
