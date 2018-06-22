module Api::V1::Session

  class AuthenticationController < ApiController
  	skip_before_action :authorize_request, only: [:authenticate, :confirm_email]

    def authenticate
      user = User.find_by(email: params[:email].to_s.downcase)
      if user && user.authenticate(params[:password])
        auth_token = JsonWebToken.encode({user_id: user.id})
        user.update_attributes(:confirmation_token => auth_token)
        response = {user_id: user.id, fullName:user.fullName, email: user.email, device_id: user.device_id, auth_token:user.confirmation_token}
        render json: {user: response}, status: :ok
      else
        render json: {error: Message.invalid_credentials}, status: :unauthorized
      end
    end

    def confirm_email
      confirm(params[:token])
    end

    def confirm(token)
      user = User.find_by(confirmation_token: token.to_s)
      if user.present?
        user.mark_as_confirmed!
        render json: {status: 'User confirmed successfully'}, status: :ok
      else
        render json: {status: 'Invalid token'}, status: :not_found
      end
    end

    def update
      token = request.headers["HTTP_AUTHORIZATION"].to_s
      user = User.find_by(confirmation_token: token)
      if !user.present?
        render json: {error: 'The email link seems to be invalid / expired. Try requesting for a new one.'}, status: :not_found
      else
        user.update_attributes(update_user_params)
        response = {user_id: user.id,fullName:user.fullName, email: user.email, device_id: user.device_id, auth_token:user.confirmation_token}
        render json: {user: response, status: 'User updated successfully'}, status: :ok
      end
    end

    def user_profile
      token = request.headers["HTTP_AUTHORIZATION"].to_s
      user = User.find_by(confirmation_token: token)
      if !user.present?
        render json: {error: Message.unauthorized}, status: :not_found
      else
        users = User.find_by(id: params[:user_id])
        if users.present?
          response = { user_id: users.id, fullName: users.fullName, email: users.email, device_id: users.device_id, auth_token: users.confirmation_token}
          render json: response, status: :ok
        else
          render json: {error: Message.user_page_not_found}, status: :not_found
        end
      end
    end

    def logout
      token = request.headers["HTTP_AUTHORIZATION"].to_s
      user = User.find_by(confirmation_token: token)
      if !user.present?
        render json: {error: Message.unauthorized}, status: :not_found
      else
        user.mark_as_confirmed!
        render json: {status: 'User confirmed successfully'}, status: :ok
      end
    end

    def upload_media
      token = request.headers["HTTP_AUTHORIZATION"].to_s
      user = User.find_by(confirmation_token: token)
      if !user.present?
        render json: {error: Message.unauthorized}, status: :not_found
      else
        if !(params[:profile_picture]).nil? 
          profile_picture = params[:profile_picture].gsub!(" ", "+")
          io = StringIO.new(Base64.decode64(profile_picture))
          io.class.class_eval { attr_accessor :original_filename, :content_type }
          io.original_filename = "profile_picture.jpg"
          io.content_type = "image/jpg"
          user.update_attributes(:profile_picture => io)
        end
        if user.save
          response = {user_id: user.id, fullName:user.fullName, email: user.email, device_id: user.device_id, auth_token:user.confirmation_token, :profile_picture_url => User.profile_picture_url(user.profile_picture)}
          render json: {user: response, status: 'User updated successfully'}, status: :ok
        else
          render json: {error: user.errors}, status: :bad_request
        end
      end
    end



    private
    def update_user_params
      params.permit(:status, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count,  :privacy_policy, :is_subscribe, :remember_created_at, :role_id , :fullName, :email, :password, :password_confirmation, :profile_picture, :country, :community, :city, :mobile, :device_id, :terms_of_use, :confirmation_token,:authentication_token)
    end

    def auth_params
      params.permit(:email, :password, :device_id)
    end

    def validate_email_update
      @new_email = params[:email].to_s.downcase
      if @new_email.blank?
        return render json: { status: 'Email cannot be blank' }, status: :bad_request

      elsif (params[:email] == !current_user.email)
        return render json: { status: 'Current Email and New email cannot be the same' }, status: :bad_request

      elsif User.email_used?(@new_email, current_user.id)
        return render json: { error: 'Email is already in use.'}, status: :unprocessable_entity
      end
    end
  end
end