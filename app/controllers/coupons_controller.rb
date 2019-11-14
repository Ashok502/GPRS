class CouponsController < ApplicationController
	before_action :get_coupon, only: ['edit', 'update', 'destroy']

	def new
		@coupon = Coupon.new
		ajax_submit?
	end

	def create
		@coupon = Coupon.new(new_params)
		@coupons = Coupon.page(params[:coupon_page]).per_page(10)
		if @coupon.save
			ajax_submit?
		end
	end

	def apply
	end

	def apply_code
		@coupon = Coupon.find_by_coupon_code_and_status(params[:coupon_code], 'New')
		@coupon_id = Coupon.find_by(coupon_code: params[:coupon_code])
		@user_coupon = UserCoupon.find_by_user_id_and_coupon_id(current_user.id, @coupon_id.id)
		if @coupon.present? && !@user_coupon.present?
			@coupon.update(cart_id: current_cart.id)
			UserCoupon.create(user_id: current_user.id, coupon_id: @coupon_id.id)
			ajax_submit?
		end
	end

	def edit
	end

	def update
		@coupons = Coupon.page(params[:coupon_page]).per_page(10)
		if @coupon.update_attributes(new_params)
			ajax_submit?
		end
	end

	def destroy
		@coupon.destroy
		ajax_submit?
	end

	private

	def get_coupon
		@coupon = Coupon.find(params[:id])
	end

	def new_params
		params.require(:coupon).permit!
	end
end
