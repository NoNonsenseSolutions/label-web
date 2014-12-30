module Api
  module V1
    class PhotosController < Api::V1::BaseController
      respond_to :json
      before_action :authenticate, except: :show

      def create
        if params[:file]
          photo_string = params[:file]
          #create a new tempfile named fileupload
          tempfile = Tempfile.new("fileupload")
          tempfile.binmode
          #get the file and decode it with base64 then write it to the tempfile
          tempfile.write(Base64.decode64(photo_string))
          tempfile.rewind()
          #create a new uploaded file
          uploaded_file = ActionDispatch::Http::UploadedFile.new(
            :tempfile => tempfile,
            :filename => "filename.jpg",
            :type => "image/jpg")

          #replace picture_path with the new uploaded file
          params[:file] =  uploaded_file
        end

        @photo = current_user.photos.build(file: params[:file])
        if @photo.save
          new_tags = Hash.new
          params[:tags].each do |field, value| 
            tag_array = value.downcase.gsub(/[^\w\d#]/, '').split(/(?=[#])/).to_a
            @photo.edit_associated_tags(tag_array, field.to_s)
          end        
          render json: {photo: @photo}, :methods => :photo_tags, :include => {comments: {only: :body}, user: {only: [:username, :photo]}}, status: 201
        else
          render json: @photo.errors, status: 402
        end
      end

    	def feed
        page = params[:page] || 0
        entries = params[:entries] || 10
        @photos = Photo.offset(page.to_i*entries.to_i).first(entries.to_i)
        render json: {photos: @photos}, :include => {user: {only: [:username, :photo]}}
      end


      def show
        @photo = Photo.find(params[:id])
        @comments = @photo.comments
        render json: {photo: @photo}, :methods => :photo_tags, :include => {comments: {only: :body}, user: {only: [:username, :photo]}}
      end

      def search
        @photos = Photo.search_by_tags(params[:keyword])
        if @photos.size > 0
          render json: {photos: @photos}, :include => {user: {only: [:username, :photo]}}
        else
          render json: {error: "No photo found"}
        end
      end

      def like
        @photo = Photo.find(params[:id])
        @like = Like.new(user_id: current_user.id, photo_id: params[:id])
        @photo.likes_count += 1
        @photo.save
        if @like.save
          render json: { total_likes: @photo.likes_count }
        else
          render json: { errors: @like.errors}
        end
      end


      private

        def photo_params
          params.require(:user).permit(:file, :tags)
        end

        def query_params
          params.permit(:oauth_token, :username)
        end

        def uploaded_photo
          return unless @photo

          tempfile = Tempfile.new ['upload', 'jpg']
          tempfile.binmode
          ActionDispatch::Http::UploadedFile.new(tempfile: tempfile,
            filename: 'upload.jpg')
        end
    end
  end
end