ActiveAdmin.register GImageCategory, as:'Category' do
  menu priority: 6

  filter :name, as: :string, label: "by name"
  filter :updated_at, label: "Select by updating date"

  actions :all, except: [:show]

  index title: 'Category' do
    selectable_column
    column :name
    column 'Total images' do |category|
      category.g_images.count
    end
    column 'Total comments' do |category|
      total = 0
      category.g_images.each do |img|
        total += img.user_comments_count
      end
      total
    end
    column 'Total likes' do |category|
      total = 0
      category.g_images.each do |img|
        total += img.likes_count
      end
      total
    end
    column :updated_at

    actions
  end

end
