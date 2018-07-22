class ProductsController < ApplicationController
  before_action :get_product, only: ['edit', 'update', 'destroy']
	
	def index
		@products = current_user.products.page(params[:product_page]).per_page(5)
		ajax_submit?
	end

	def new
		@product = Product.new
		1.times {@product.logos.build}
		ajax_submit?
	end

	def create
		@product = Product.new(new_params.merge(user_id: current_user.id))
		1.times{@product.logos.build} if @product.logos.blank?
		@products = current_user.products.page(params[:product_page]).per_page(5)
		if @product.save
			ajax_submit?
		end
	end

	def edit
	end

	def update
		@products = current_user.products.page(params[:product_page]).per_page(5)
		if @product.update_attributes(new_params)
			ajax_submit?
		end
	end

	def destroy
		@product.destroy
		ajax_submit?
	end

	private

	def get_product
		@product = Product.find(params[:id])
	end

	def new_params
		params.require(:product).permit!
	end
end

