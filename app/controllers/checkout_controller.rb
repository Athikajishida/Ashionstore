# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
  layout "user_layouts"
  before_action :authenticate_user!, only: [:index, :create_order]

  def index
    @user = current_user
    @addresses = current_user.addresses
    @order = Order.new
    set_discounted_total_session
    @cart_item = current_user.cart
  end

  def create_order
    order_params = params.require(:order).permit(:address_id, :payment_method, :discounted_total)

    if order_params[:payment_method] == 'check-payment'
      handle_cash_on_delivery(order_params)
    elsif order_params[:payment_method] == 'razorpay'
      handle_razorpay(order_params)
    else
    end
  end

  def order_success
  end

  private

  def handle_cash_on_delivery(order_params)
    @order = Order.create(
      order_params.merge(
        status: 'pending',
        user_id: current_user.id,
        payment_status: 'pending',
        cart_id: current_user.cart.id ,
      )
    )
    if @order.save
      current_user.cart.cart_items.each do |cart_item|
        order_item = OrderItem.create(
          order_id: @order.id,
          product_id: cart_item.product.id,
          quantity: cart_item.quantity,
          unit_price: cart_item.product.price
        )
  
        unless order_item.valid?
          # Handle validation errors if necessary
          flash[:error] = order_item.errors.full_messages.join(', ')
          redirect_to checkout_index_path
          return
        end
      end
  
      current_user.cart.cart_items.destroy_all
      set_discounted_total_session
      redirect_to order_success_path
    else
      flash[:error] = @order.errors.full_messages.join(', ')
      redirect_to checkout_index_path
    end
  end

  def handle_razorpay(order_params)
    order = Order.create(
      order_params.merge(
        status: 'pending',
        user_id: current_user.id,
        payment_status: 'pending',
        cart_id: current_user.cart.id
      )
    )
  
    razorpay_order = Razorpay::Order.create(amount: order.discounted_total * 100, currency: 'INR', receipt: 'TEST')
  
    # Store Razorpay order_id in your order record
    order.update(razorpay_order_id: razorpay_order.id)
  
    render json: { order_id: razorpay_order.id, amount: razorpay_order.amount }
    render 'checkout/razorpay_checkout', layout: false

  end
  def razorpay_payment_success
    order = Order.find(params[:order_id])
    order.update(payment_status: 'paid')
  
    # ...
  
    redirect_to order_success_path
  end
  def order_params
    params.require(:order).permit(:address_id, :payment_method, :other_order_attributes)
  end

  def set_discounted_total_session
    session[:cart_discounted_total] = params[:discountedTotal]
  end
end
