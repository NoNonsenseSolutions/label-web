class UsersController < ApplicationController
	before_action :logged_in_user

	def show
		@user = User.find(params[:id])
		@photo = @user.photo.build
		@photos = @user.photos
	end

	def edit
	end

	def update
	end

end

