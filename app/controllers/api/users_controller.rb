module Api
  class UsersController < Api::BaseController
    before_action :authenticate, except: :create

  	def create      
  		begin
    		@graph = Koala::Facebook::API.new(params[:oauth_token])
    		profile = @graph.get_object("me")
        uid = @graph.get_object("me")["id"]
        @user = User.find_or_create_by(uid: uid)
        @user.oauth_token = params[:oauth_token]
    		@user.gender = profile["gender"]
    		@user.provider = "facebook"
    		@user.uid = profile["id"]
    		@user.name = profile["first_name"] + profile["last_name"]
    		@user.save
      rescue
      	@user = nil
      end

      if @user && @user.save
        render json: @user, status: :created, location: @user
      elsif !@user
      	render json: {error: "oauth token invalid"}, status: :unprocessable_entity
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  	end

    private

      def user_params
        params.require(:user).permit(:oauth_token)
      end

      def query_params
        params.permit(:oauth_token, :username)
      end

      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          User.find_by(oauth_token: token)
        end
      end
  end
end