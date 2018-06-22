ActiveAdmin.register BuyerRequirement do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :title, :description, :country, :city, :buyer_id, :seller_id, :area, :requirement_image
actions :all, :except => [:edit, :new]
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :country
    column :city
    column :user_id
    column :area
    actions
  end

  filter :title
  filter :country
  filter :user_id
  filter :area
  filter :created_at

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :title
      f.input :country, as: :string
      f.input :city
      f.input :user_id
      f.input :area
      f.input :requirement_image, required: true, as: :file
      f.input :description
    end
    f.actions
  end

end
