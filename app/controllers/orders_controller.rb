class OrdersController < ApplicationController
  layout 'admin_layouts', except: [:generate_invoice]
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def change_status
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to orders_path, notice: 'Order status updated successfully.'
  end
  def generate_invoice
     @user = current_user
     @last_order = @user.orders.last

     if @last_order
       @order_items = @last_order.order_items
       @grand_total = calculate_grand_total(@order_items)
       @address = @last_order.address
       render layout: 'user_layouts', template: 'order/generate_invoice'

    else
      flash[:error] = "No orders found."
       redirect_to root_path
     end
  end
  private

def calculate_grand_total(order_items)
  order_items.present? ? order_items.sum { |item| item.unit_price * item.quantity } : 0
end
end
