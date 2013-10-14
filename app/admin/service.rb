ActiveAdmin.register Service, as:'Social Network Providers' do
  menu priority: 4

  filter :provider, as: :select, label: 'Select provider', collection: proc { Service.pluck(:provider).uniq }
  filter :user_name, as: :string, label: 'by name'
  filter :uemail, as: :string, label: 'by email'
  filter :user_created_at, as: :date_range, label: 'Search by creation date'

  actions :index, :destroy

  index do
    selectable_column
    column :id
    column 'Name', sortable: :uname do |service|
      link_to service.uname, admin_user_path(service.user.id)
    end
    column :provider
    column 'Email', :uemail
    column 'UID', :uid
    column 'Created at', sortable: 'users.created_at' do |service|
      service.user.created_at.strftime("%e %B %Y, %R")
    end

    actions
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(:user)
    end
  end
end
