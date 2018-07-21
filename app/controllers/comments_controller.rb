class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comments = @post.comments.order(:created_at)
		@comment = @post.comments.new(new_params.merge(user_id: current_user.id))
		if @comment.save
			ajax_submit?
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		ajax_submit?
	end

	private
	def new_params
		params.require(:comment).permit!
	end
end
