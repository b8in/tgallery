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

  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions do
      label = f.object.new_record? ? 'Create' : 'Update'
      f.action :submit, label: "#{label} Category", button_html: { disable_with: 'Wait...' }
      f.action :cancel, label: 'Cancel', wrapper_html: { class: 'cancel'}
    end
  end

end
