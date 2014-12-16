module Api
  module V1
    class PhotosController < Api::V1::BaseController
      respond_to :json

    	def index
        @photos = Photo.all.reverse
        render json: @photos
      end

      def show
        @photo = Photo.find(params[:id])
        render json: @photo
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
end