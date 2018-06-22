ActiveAdmin.register Category do
permit_params :name, :category_image
#actions :all, :except => [:edit, :destroy]
#config.filters = false

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :name
      f.input :category_image, required: true, as: :file
      
    end
    f.actions
  end

end
