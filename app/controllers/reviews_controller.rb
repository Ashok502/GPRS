class ReviewsController < ApplicationController
	def new
		@product = Product.find(params[:product_id])
		@review = @product.reviews.new
		ajax_submit?
	end

	def create
		@product = Product.find(params[:product_id])
		@reviews = @product.reviews.page(params[:review_page]).per_page(5)
		@review = @product.reviews.new(new_params.merge(product_id: @product.id, user_id: current_user.id))
		if @review.save
			ajax_submit?
		end
	end

	private
	
	def new_params
		params.require(:review).permit!
	end
end
