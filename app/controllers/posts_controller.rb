class PostsController < ApplicationController
  
  def create
  	@user = current_user
  	@posts = Post.all
  	@post = Post.new(post_params.merge(user_id: @user.id))
  	if @post.save
      Notification.create(:post_id => @post.id, :user_id => @user.id)
  		ajax_submit?
  	end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy 
    ajax_submit?
  end

  private

  def post_params
  	params.require(:post).permit!
  end
end
