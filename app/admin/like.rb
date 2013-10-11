ActiveAdmin.register Like do
  actions :index, :destroy

  index do
    selectable_column
    column 'Image' do |like|
      image_tag(like.g_image.image.url(:thumb), height: 40)
    end
    column 'Image name', sortable: 'g_images.name' do |like|
      link_to like.g_image.name, admin_image_path(like.g_image.id)
    end
    column 'User', sortable: 'users.name' do |like|
      link_to("#{like.e_history.user.name}, <#{like.e_history.user.email}>", admin_user_path(like.e_history.user.id))
    end

    actions
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:g_image, :e_history => [:user])
    end
  end

end