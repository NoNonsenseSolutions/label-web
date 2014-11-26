module Api
  class UsersController < Api::BaseController

    private

      def user_params
        params.require(:user).permit(:oauth_token)
      end

      def query_params
        params.permit(:oauth_token, :username)
      end

  end
end