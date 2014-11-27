module Api
  class UsersController < Api::BaseController

  	def create
      @user = (User.new(user_params))

      if @user.save
        render :show, status: :created
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

  end
end