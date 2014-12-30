module Api
	module V1
		class CommentsController < Api::V1::BaseController
			respond_to :json
			before_action :authenticate

			def create
				@photo = Photo.find(params[:photo_id])
				@comment = @photo.comments.build(comment_params)
				@comment.user_id = current_user.id
				if @comment.save
					render json: { comment: @comment }
				else
					render json: { error: "Invalid comment"}
				end
			end

			private
				def comment_params
					params.require(:comment).permit(:body)
				end
		end
	end
end