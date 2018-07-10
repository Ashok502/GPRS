class IntrestsController < ApplicationController
	def create
		@user = current_user	
		@intrests = @user.intrests	
		@intrest = Intrest.new(post_params.merge(user_id: @user.id))
		if @intrest.user.limit_intrests? <= 10 && @intrest.save
			respond_to do |format|
				format.js
			end
		end
	end

	private

	def post_params
		params.require(:intrest).permit!
	end
end
