class AddAuthorToUserComments < ActiveRecord::Migration
  def change
    add_column :user_comments, :author, :string, default: nil
  end
end
