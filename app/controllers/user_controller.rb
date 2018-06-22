class UserController < ApplicationController

	def index
		
	end

	def new
		@user = User.new
	end

	def create

	  @user = User.new(user_params)
	  puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK#{@user.inspect}"
	  # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
	  @user.email.downcase!
	   if @user.save
	   	session[:user_id] = @user.id
	     # If user saves in the db successfully:
	     flash[:notice] = "Account created successfully!"
	     redirect_to root_path
	   else
	     # If user fails model validation - probably a bad password or duplicate email:
	     flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
	     render :new
	   end
	end

private

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:password_digest,:status, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count,  :privacy_policy, :is_subscribe, :remember_created_at, :role_id , :fullName, :email, :password, :password_confirmation, :profile_picture, :country, :community, :city, :mobile, :device_id, :terms_of_use, :confirmation_token,:authentication_token)
  end
  
# ----- end of added lines -----

end
