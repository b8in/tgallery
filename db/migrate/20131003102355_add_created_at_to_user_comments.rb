class AddCreatedAtToUserComments < ActiveRecord::Migration
  def change
    add_column :user_comments, :created_at, :datetime
  end
end
