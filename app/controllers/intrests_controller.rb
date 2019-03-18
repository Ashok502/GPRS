class IntrestsController < ApplicationController
	def create
		@user = current_user	
		@intrests = @user.intrests.order(created_at: 'desc')
		@intrest = Intrest.new(post_params.merge(user_id: @user.id))
		if @intrest.user.limit_intrests? <= 10 && @intrest.save
			ajax_submit?
		end
	end

	def destroy
		@intrest = Intrest.find(params[:id])
		@intrest.destroy 
		ajax_submit?
	end

	private

	def post_params
		params.require(:intrest).permit!
	end
end
