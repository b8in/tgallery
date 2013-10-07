ActiveAdmin.register UserComment do
  index do
    column :id
    column 'Author' do |com|
      com.author ? com.author : link_to("#{com.e_history.user.name}, <#{com.e_history.user.email}>", admin_user_path(com.e_history.user.id))
    end
    column :text do |com|
      truncate(com.text, length: 150)
    end
    column 'Image' do |com|
      link_to com.g_image.name, '#'
    end
    column :created_at, sortable: :created_at do |user|
      user.created_at.strftime("%e %B %Y, %R")
    end

    actions
  end

end