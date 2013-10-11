ActiveAdmin.register GImage, as:'Image' do

  filter :name, label: 'by name'
  filter :g_image_category, label: 'Category'
  filter :likes_count
  filter :user_comments_count, label: 'Comments count'
  filter :created_at

  #actions :index, :show

  index title: 'Image' do
    selectable_column
    column :id
    column 'Image' do |img|
      image_tag(img.image.url(:thumb), width:64)
    end
    column :name
    column 'Category', :g_image_category, sortable: 'g_image_categories.name'    #important: works with scoped_collection method
    column 'URL' do |img|
      "/public#{img.image.url.to_s}"
    end
    column :likes_count, sortable: :likes_count
    column 'Comments count', :user_comments_count, sortable: :user_comments_count
    column :created_at

    actions
  end

  show do |img|
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

    def update
      new_category_id = params[:image][:g_image_category_id]
      @image = GImage.find(params[:id])
      old_category_id = @image.g_image_category_id

      if new_category_id.nil?
        new_store_dir = 'without_category'
      else
        new_store_dir = GImageCategory.where(id: new_category_id).pluck(:name)[0]
      end

      if old_category_id.nil?
        old_store_dir = 'without_category'
      else
        old_store_dir = GImageCategory.where(id: old_category_id).pluck(:name)[0]
      end

      old_file_path =  "#{Rails.root}/public#{@image.image.url}"

      unless @image.update_attributes(params[:image])
        render :edit
      else
        arr = old_file_path.rpartition('/')
        stored_image_name = arr[2]
        old_store_dir_path = arr[0]

        Dir.chdir(old_store_dir_path)
        pattern = "*"+stored_image_name.to_s
        moved_files_names = Dir.glob(pattern)
        moved_files_names.each do |fname|
          new_name = fname.gsub(stored_image_name, @image.name)
          new_file_path = old_store_dir_path.rpartition('/')[0] + "/#{new_store_dir}/#{new_name}"
          FileUtils.mv(old_store_dir_path+'/'+fname, new_file_path)
        end

        @image.image = File.open(old_store_dir_path.rpartition('/')[0] + "/#{new_store_dir}/#{@image.name}")
        @image.save!
        redirect_to admin_image_path(@image), notice: 'Image was successfully updated.'
      end

    end

    def scoped_collection
      end_of_association_chain.includes(:g_image_category)
    end

  end

  form do |f|
    f.semantic_errors :base
    f.inputs 'Image Datails' do
      f.input :g_image_category, label: 'Category name:'
      f.input :name, label: 'Image name'
      if f.object.new_record?
        f.input :image, as: :file, label: 'Image'
      end
    end
    f.actions do
      label = f.object.new_record? ? 'Create' : 'Update'
      f.action :submit, label: label, button_html: { disable_with: 'Wait...' }
      f.action :cancel, label: 'Cancel', wrapper_html: { class: 'cancel' }
    end
  end
end
