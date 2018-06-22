  module Api::V1::Registration
    class UsersController < ApiController
     skip_before_action :authorize_request, only: :create
     def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      user.confirmation_token = auth_token
      if user.save
        response = {user_id: user.id, fullName:user.fullName, email: user.email,device_id: user.device_id, auth_token:user.confirmation_token}
        url = "#{request.base_url}/confirm_email?token=#{user.confirmation_token}"
        UserMailer.welcome_email(user,url).deliver_now
        render json: {user: response, message: Message.account_created}, status: :created
      else
        response = { message: user.errors, status: :bad }
        render json: user.errors, status: :bad
      end 

    end

    private

    def user_params
      params.permit(:status, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count,  :privacy_policy, :is_subscribe, :remember_created_at, :role_id , :fullName, :email, :password, :password_confirmation, :profile_picture, :country, :community, :city, :mobile, :device_id, :terms_of_use, :confirmation_token,:authentication_token)
    end
  end
end
