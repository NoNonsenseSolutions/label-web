module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :authenticate, except: :create
      respond_to :json

    	def create      
    		begin
      		@graph = Koala::Facebook::API.new(params[:oauth_token])
      		profile = @graph.get_object("me")
          uid = @graph.get_object("me")["id"]
          @user = User.find_or_create_by(uid: uid)
          @user.oauth_token = params[:oauth_token]
      		@user.gender = profile["gender"]
          @user.remote_profile_pic_url = @graph.get_picture(profile['id'], width: 9999)
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

      def personal_feed
        page = params[:page] || 0
        entries = params[:entries] || 10
        @photos = current_user.photos.reverse_order.offset(page.to_i*entries.to_i).first(entries.to_i)
        render json: {photos: @photos}, :include => {user: {only: [:name, :profile_pic]}}
      end

      def favourites_feed
        page = params[:page] || 0
        entries = params[:entries] || 10
        @photos = Photo.where(id: Like.where(user: current_user).pluck(:photo_id)).reverse_order.offset(page.to_i*entries.to_i).first(entries.to_i)
        render json: {photos: @photos}, :include => {user: {only: [:name, :profile_pic]}}
      end


      private

        def user_params
          params.require(:user).permit(:oauth_token)
        end

        def query_params
          params.permit(:oauth_token, :username)
        end
    end
  end
end