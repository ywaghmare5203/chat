class BuyerRequirementController < ApiController

	def create
		token = request.headers["HTTP_AUTHORIZATION"].to_s
		user = User.find_by(confirmation_token: token)
		if !user.present?
        	render json: {error: Message.unauthorized}, status: :not_found
      	else
      		#puts "79797979797979797979797979797979797979797979977979#{params.inspect}"
      		buyer_post = BuyerRequirement.create(buyer_requirement_params)
      		if !(params[:requirement_image]).nil? 
		        requirement_image = BuyerRequirement.upload_requirement_image(params[:requirement_image])
		    end
      		if buyer_post.save!
          		render json: buyer_post, status: :ok
          	else
          		render json: {error: buyer_post.errors}, status: :not_found
          	end
        end
	end

	private
  		def buyer_requirement_params
    		params.permit(:title,:description,:country, :city, :user_id, :requirement_image)
  		end
end