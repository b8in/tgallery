class ChangeHEventsToPolymorphic < ActiveRecord::Migration
  def up
    add_column :e_histories, :eventable_id, :integer
    add_column :e_histories, :eventable_type, :string

    remove_column :likes, :e_history_id
    remove_column :user_comments, :e_history_id
    remove_column :navigations, :e_history_id
  end

  def down
    add_column :navigations, :e_history_id, :integer
    add_column :user_comments, :e_history_id, :integer
    add_column :likes, :e_history_id, :integer

    remove_column :e_histories, :eventable_id
    remove_column :e_histories, :eventable_type
  end
end
