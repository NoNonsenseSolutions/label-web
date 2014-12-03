class UsersController < ApplicationController
	before_action :logged_in_user

	def show
		@user = User.find(params[:id])
		@photos = @user.photos.reverse
	end

	def edit
	end

	def update
	end

end

