class CommentsController < ApplicationController
	def create
		@photo = Photo.find(params[:photo_id])
		@comment = @photo.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Comment posted"
		else
			flash[:danger] = "Invalid Comment"
		end
		redirect_to "/photos/#{params[:photo_id]}"
	end

	private
		def comment_params
			params.require(:comment).permit(:body)
		end

end
