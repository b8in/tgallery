ActiveAdmin.register GImage, as:'Image' do

  filter :name, label: 'Search by name'
  filter :g_image_category, label: 'Category'
  filter :likes_count
  filter :user_comments_count, label: 'Comments count'
  filter :created_at

  index title: 'Image' do
    selectable_column
    column :id
    column 'Image' do |img|
      image_tag(img.image.url(:thumb), width:64)
    end
    column :name
    column 'Category', :g_image_category #, sortable: :g_image_category.
    column 'URL' do |img|
      img.image.url.to_s
    end
    column :likes_count, sortable: :likes_count
    column 'Comments count', :user_comments_count, sortable: :user_comments_count
    column :created_at

    actions
  end

  show do  |img|
    attributes_table do
      row :id
      row :name
      row :image do
        image_tag(img.image.url(:thumb))
      end
      row 'TGallery link' do
        link_to(picture_path(img.g_image_category.name, img.id), picture_path(img.g_image_category.name, img.id))
      end
      row 'URL' do
        img.image.url.to_s
      end
      row 'Category' do
        link_to img.g_image_category.name, admin_category_path(img.g_image_category.id)
      end
      row :likes_count
      row 'Comments count' do
        img.user_comments_count
      end
      row :created_at
    end
  end

  controller do
    def create
      category = GImageCategory.find(params[:image][:g_image_category_id])
      params[:image].delete(:g_image_category_id)
      if category.g_images.create(params[:image])
        flash[:notice] = "New image #{params[:image][:name]} uploaded successfully"
        redirect_to admin_images_path
      else
        flash[:alert] = "Error. Image #{params[:image][:name]} not uploaded"
        render "new"
      end
    end
  end
end
