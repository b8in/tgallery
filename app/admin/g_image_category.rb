ActiveAdmin.register GImageCategory, as:'Category' do

  filter :name, as: :string, label: "by name"
  filter :updated_at, label: "Select by updating date"

  index title: 'Category' do
    selectable_column
    column :name
    column :updated_at
    actions
  end

end
