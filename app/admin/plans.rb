ActiveAdmin.register Plan do
permit_params :title, :description, :amount, :duration, :status
#actions :all, :except => [:edit, :destroy]
#config.filters = false
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :amount
    column :duration
    column :status
    column :created_at
    actions
  end

  filter :title
  filter :amount
  filter :duration
  filter :status
  filter :created_at

  form do |f|
    
    f.inputs do
      f.input :title, :require => true
      f.input :amount
      f.input :duration
      f.input :description
      f.input :status
    end
    f.actions
  end

end
