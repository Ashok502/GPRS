class ProductsController < ApplicationController
	before_action :get_product, only: ['edit', 'update', 'destroy','add_to_cart']
	
	def index
		@products = Product.page(params[:product_page]).per_page(5)
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
		@products = Product.page(params[:product_page]).per_page(5)
		if @product.save
			ajax_submit?
		end
	end

	def edit
	end

	def add_to_cart
		@cart = current_cart
		@cart.update_attribute(:created_at, Time.now)
		session[:cart] = @cart.id
		@line_item = LineItem.find_by_product_id_and_cart_id(@product.id,@cart.id)
		@qty = (@product.quantity >= params[:quantity].to_i)
		if @qty == true
			if @line_item.present?
				@line_item.update(quantity: params[:quantity])
			else
				LineItem.create(product_id: @product.id, cart_id: @cart.id, unit_price: @product.price, quantity: params[:quantity])
			end
		end
		ajax_submit?
	end

	def update
		@products = Product.page(params[:product_page]).per_page(5)
		if @product.update_attributes(new_params)
			ajax_submit?
		end
	end

	def destroy
		@product.destroy
		ajax_submit?
	end

	def item_delete
		@item = LineItem.find(params[:id])
		@item.destroy
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

