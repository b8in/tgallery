ActiveAdmin.register WatchingCategory do

  filter :user_name, as: :string, label: 'by user name'
  filter :g_image_category_name, as: :select, label: 'by category name', collection: proc { GImageCategory.all }

  index title: 'User watch categories' do
    selectable_column
    column 'User' do |wc|
      link_to("#{wc.user.name}, <#{wc.user.email}>", admin_user_path(wc.user.id))
    end
    column  'Image category', :g_image_category

    actions
  end
end
