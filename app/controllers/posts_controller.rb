class PostsController < ApplicationController
  
  def create
  	@user = current_user
  	@posts = Post.all
  	@post = Post.new(post_params.merge(user_id: @user.id))
  	if @post.save
      Notification.create(:post_id => @post.id, :user_id => @user.id)
      @notifications = @user.notifications.count
  		ajax_submit?
  	end
  end

  def destroy
    @post = Post.find(params[:id])
    @posts = Post.all
    @post.destroy 
    @notifications = current_user.notifications.count
    ajax_submit?
  end

  private

  def post_params
  	params.require(:post).permit!
  end
end
