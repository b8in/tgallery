ActiveAdmin.register User do
  menu priority: 3

  filter :name
  filter :email
  filter :admin, as: :select
  filter :created_at, as: :date_range
  filter :last_sign_in_at, as: :date_range


  index do
    selectable_column
    column :id
    column :name
    column :email, sortable: :email do |user|
      link_to user.email, admin_user_path(user.id)
    end
    column 'Role', sortable: :admin do |user|
      user.admin ? 'ADMIN' : 'User'
    end
    column 'Likes count'do |user|
      Like.joins(:e_history).where('e_histories.user_id' => user.id).count
    end
    column 'Comments count' do |user|
      UserComment.joins(:e_history).where('e_histories.user_id' => user.id).count
    end
    column :created_at, sortable: :created_at do |user|
      user.created_at.strftime("%e %B %Y, %R")
    end
    column :last_sign_in_at, sortable: :last_sign_in_at do |user|
      user.last_sign_in_at.strftime("%e %B %Y, %R")
    end
    column :last_sign_in_ip

    actions

  end


  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
      row 'role' do
        user.admin ? 'ADMIN' : 'User'
      end
      row 'Total comments' do
        user.user_comments.count
      end
      row 'Total likes' do
        user.likes.count
      end
      row 'watching categories' do
        user.watching_categories.count
      end
      row :encrypted_password
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end


  form do |f|
    f.semantic_errors :base
    f.inputs 'User Details' do
      f.input :name
      f.input :email
      f.input :admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions do
      label = f.object.new_record? ? 'Create' : 'Update'
      f.action :submit, label: label, button_html: { disable_with: 'Wait...' }
      f.action :cancel, label: 'Cancel', wrapper_html: { class: 'cancel' }
    end
  end

end