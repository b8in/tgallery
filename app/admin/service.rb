ActiveAdmin.register Service, as:'Social Network Providers' do

  filter :provider, as: :select, label: 'Select provider', collection: proc { Service.pluck(:provider).uniq }
  filter :user_name, as: :string, label: 'by name'
  filter :uemail, as: :string, label: 'by email'
  filter :user_created_at, as: :date_range, label: 'Search by creation date'

  index do
    selectable_column
    column :id
    column 'Name' do |service|
      link_to service.uname, admin_user_path(service.user.id)
    end
    column :provider
    column 'Email', :uemail
    column 'UID', :uid
    column 'Created at' do |service|
      service.user.created_at
    end

    actions
  end
end
