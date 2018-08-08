class DashboardsController < ApplicationController
	def index
		@categories = Category.page(params[:category_page]).per_page(10)
		@products = Product.page(params[:product_page]).per_page(10)
		@invoices = Order.page(params[:order_page]).per_page(10)
		@users = User.where.not(role: 'admin').page(params[:user_page]).per_page(10)
		@coupons = Coupon.all.page(params[:coupon_page]).per_page(10)
		@ads = Ad.page(params[:ad_page]).per_page(10)
		render layout: 'admin'
	end
end
