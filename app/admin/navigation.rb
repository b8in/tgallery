ActiveAdmin.register Navigation do
  actions :index, :destroy

  filter :e_history_user_name_or_e_history_user_email, as: :string, label: 'by user name or email'
  filter :target_url, label: 'by target url'
  filter :e_history_date, as: :date_range, label: 'Search by date'

  index do
    selectable_column
    column 'User', sortable: 'users.name' do |nav|
      link_to("#{nav.e_history.user.name}, <#{nav.e_history.user.email}>", admin_user_path(nav.e_history.user.id))
    end
    column :target_url
    column 'Date', sortable: 'e_histories.date' do |nav|
      nav.e_history.date.strftime("%e %B %Y, %R")
    end

    actions
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(e_history: [:user])
    end
  end
end
