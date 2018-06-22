ActiveAdmin.register User do
permit_params :email, :password, :password_confirmation, :fullName, :mobile, :country, :city, :terms_of_use, :privacy_policy, :status, :profile_picture
#config.filters = false
  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form :html => { :enctype => "multipart/form-data" } do |f|
    
    f.inputs do
      f.input :email, :require => true
      f.input :fullName
      f.input :mobile
      f.input :country, as: :string
      f.input :city
      f.input :password
      f.input :password_confirmation
      f.input :profile_picture, required: true, as: :file
      f.input :terms_of_use
      f.input :privacy_policy
      f.input :status
      f.input :is_subscribe
    end
    f.actions
  end
end
