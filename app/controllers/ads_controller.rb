class AdsController < ApplicationController
	def create
		@user = current_user	
		@ads = @user.ads	
		@ad = Ad.new(post_params.merge(user_id: @user.id))
		if @ad.user.limit_ads? <= 5 && @ad.save
			respond_to do |format|
				format.js
			end
		end
	end

	private

	def post_params
		params.require(:ad).permit!
	end
end
