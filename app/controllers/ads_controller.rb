class AdsController < ApplicationController

	def new
		@ad = Ad.new
		ajax_submit?
	end
	
	def create
		@user = current_user	
		@ads = Ad.page(params[:ad_page]).per_page(10)
		@ad = Ad.new(post_params.merge(user_id: @user.id))
		if @ad.user.limit_ads? <= 5 && @ad.save
			ajax_submit?
		end
	end

	def destroy
		@ad = Ad.find(params[:id])
		@ad.destroy 
		ajax_submit?
	end

	private

	def post_params
		params.require(:ad).permit!
	end
end
