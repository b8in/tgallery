ActiveAdmin.register UserComment, as:'Comment' do
  menu priority: 5

  filter :text, label: 'in comments text'
  filter :author_or_e_history_user_name, as: :string, label: 'by author'
  filter :g_image_name, as: :string, label: 'by image name'
  filter :created_at, label: 'Select by creation date'

  actions :index, :destroy

  index do
    selectable_column
    column :id
    column 'Author' do |com|
      com.author ? com.author : link_to("#{com.e_history.user.name}, <#{com.e_history.user.email}>", admin_user_path(com.e_history.user.id))
    end
    column :text do |com|
      truncate(com.text, length: 150)
    end
    column 'Image' do |com|
      link_to com.g_image.name, admin_image_path(com.g_image_id)
    end
    column :created_at, sortable: :created_at do |user|
      user.created_at.strftime("%e %B %Y, %R")
    end

    actions
  end


end