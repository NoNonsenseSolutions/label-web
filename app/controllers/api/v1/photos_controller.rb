module Api
  module V1
    class PhotosController < Api::V1::BaseController
      respond_to :json

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
          render json: @photo, status: 201
        else
          render json: @photo.errors, status: 402
        end
      end

    	def index
        @photos = Photo.all.reverse
        render json: @photos
      end

      def show
        @photo = Photo.find(params[:id])
        @comments = @photo.comments
        render json: @photo
      end

      private

        def photo_params
          params.require(:user).permit(:file)
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