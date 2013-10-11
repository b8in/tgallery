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

end