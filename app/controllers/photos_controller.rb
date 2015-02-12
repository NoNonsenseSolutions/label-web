class PhotosController < ApplicationController
	before_action :logged_in_user
	before_action :photo_find, only: [:show, :edit, :update, :destroy]

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
		@photo = current_user.photos.build(remote_file_url: params[:image])
		if @photo.save
			flash[:success] = "Photo created!"
			redirect_to "/photos/#{@photo.id}/edit"
		else
			render 'new'
		end
	end

	def show
		@user = @photo.user
		@comment = @photo.comments.build
		@comments = @photo.comments.order(created_at: :desc)
	end

	def edit
	end

	def update
		tags = params[:photo][:tags]
    tags.each do |field, value| 
      tag_array = value.downcase.gsub(/[^\w\d#]/, '').split(/(?=[#])/).to_a
      @photo.edit_associated_tags(tag_array, field.to_s)
    end  
		# Array.wrap(params[:photo][:color_attributes]).each do |color|
		# 	hashtags << color["hex"]
		# end
		# Array.wrap(hashtags).each do |hashtag|
		# 	tag = Tag.find_or_create_by(field: hashtag)
		# 	@photo.tags << tag
		# end
		@photo.update(photo_params)
		redirect_to @photo
	end

	def destroy
		@photo.tags.delete_all
		@photo.destroy
		redirect_to '/'
	end


  def search
    keyword = params["keyword"]
    keyword = "##{keyword}" unless keyword[0] == "#"
    tags = Tag.where(value: keyword)
    photos_with_title = Photo.title_search("#{params[:keyword]}")
    @photos = tags.map(&:photo) + photos_with_title
    @photos = @photos.uniq
    render 'search_results'
  end

	private
		def photo_find
			@photo = Photo.find(params[:id])
		end

		def photo_params
			params.require(:photo).permit(:file, :image, :title)
		end
end
