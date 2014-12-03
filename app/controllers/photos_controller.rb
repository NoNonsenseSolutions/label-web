class PhotosController < ApplicationController
	before_action :logged_in_user

	def new
    @photo = current_user.photos.build
	end

	def create
		@photo = current_user.photos.build(photo_params)
		if @photo.save
			flash[:success] = "Photo created!"
			redirect_to "/photos/#{@photo.id}/edit"
		else
			render 'new'
		end
	end

	def pixlr
		@photo = current_user.photos.build(remote_file_url: params[image])
		if @photo.save
			flash[:success] = "Photo created!"
			redirect_to "/photos/#{@photo.id}/edit"
		else
			render 'new'
		end
	end

	def show
		@photo = Photo.find(params[:id])
		@user = @photo.user
		@comment = @photo.comments.build
		@comments = @photo.comments.order(created_at: :desc)
	end

	def edit

	end

	private
		def photo_params
			params.require(:photo).permit(:file, :image)
		end
end
