class RenameColumnGImageCategoryId < ActiveRecord::Migration
  def change
    rename_column :paintings, :GImageCategory_id, :g_image_category_id
  end
end
