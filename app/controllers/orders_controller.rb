class OrdersController < ApplicationController
  before_action :is_login?
  respond_to :html, :json
  def express
    response = EXPRESS.setup_purchase(current_cart.total * 100,
      :ip => request.remote_ip,
      :return_url => new_order_url,
      :cancel_return_url => root_url,
      :allow_note => true,
      :items => current_cart.cart_details
      )
    redirect_to EXPRESS.redirect_url_for(response.token)
  end

  def new
    @order = Order.new(:express_token => params[:token])
  end

  def create
    @cart = current_cart
    @order = Order.new(params_order.merge(user_id: current_user.id, cart_id: @cart.id))
    if @order.purchase && @order.success == true
      for item in @cart.line_items
        item.product.update_attribute(:quantity, item.product.quantity - item.quantity)
      end
      @cart.update_attribute(:published_at, Date.today)
      if @cart.coupon.present?
        @cart.coupon.update(status: 'Applied')
      end
      session[:cart] = nil
      redirect_to "/"
    else
      render :action => "new"
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params_order)
    respond_with @order
  end

  def index
    ajax_submit?
  end

  def show
    @order = Order.find(params[:id])
    ajax_submit?
  end

  private
  def params_order
    params.require(:order).permit!
  end
end
