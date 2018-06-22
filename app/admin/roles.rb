ActiveAdmin.register Role do

permit_params :name, :status
#actions :all, :except => [:edit, :destroy]
#config.filters = false
  index do
    selectable_column
    id_column
    column :name
    column :status
    column :created_at
    actions
  end

  filter :name
  filter :status

  form do |f|
    
    f.inputs do
      f.input :name, :require => true
      f.input :status
    end
    f.actions
  end

end
