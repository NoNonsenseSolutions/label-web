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
		@hash_tags = @photo.tags.hash_tags.map(&:field)
		@color_tags = @photo.tags.color_tags.map(&:field)
	end

	def update
		hash_tags = params[:photo][:hashtags].downcase.gsub(/[^\w\d#]/, '').split(/(?=[#])/).to_a
		color_tags = params[:photo][:color_attributes].to_a.map {|attr| attr["hex"] }
		new_tags = hash_tags + color_tags
		@photo.edit_associated_tags(new_tags)
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
    keyword = params[:keyword]
    keyword = "##{keyword}" if keyword[0] != "#"
    tag = Tag.find_by(field: keyword)
    photos_with_title = Photo.title_search("#{params[:keyword]}")
    @photos = tag.try(:photos).to_a + photos_with_title
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
