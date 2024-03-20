class OrdersController < ApplicationController
  layout 'admin_layouts', except: [:generate_invoice]
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
  def show_user_side
    @orders = current_user.orders.includes(:order_items)
    if @orders.empty?
      flash[:notice] = "You haven't placed any orders yet."
      render layout: 'user_layouts'
    else
      render layout: 'user_layouts'
    end
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
       render layout: 'user_layouts', template: 'orders/generate_invoice'

    else
      flash[:error] = "No orders found."
       redirect_to root_path
     end
    end
    def view_orders_and_return_items
      @user = current_user
      @orders = @user.orders
      render layout: 'user_layouts', template: 'orders/view_orders_and_return_items'
    end
    def return_items
      @order = Order.find(params[:id])
      @item = @order.order_items.find(params[:item_id])
      @quantity_returned = params[:quantity].to_i
  
      if @quantity_returned.positive? && @item.quantity >= @quantity_returned
        @item.update(quantity: @item.quantity - @quantity_returned)
        @refund_amount = @item.unit_price * @quantity_returned
        flash[:notice] = "Item returned successfully. Refund initiated for $#{'%.2f' % @refund_amount}."
      else
        flash[:error] = "Invalid quantity or item cannot be returned."
      end
      render layout: 'user_layouts', template: 'orders/show_userside' 
      redirect_to order_path(@order)
    end
  private

def calculate_grand_total(order_items)
  order_items.present? ? order_items.sum { |item| item.unit_price * item.quantity } : 0
end
end
                                                                                                                                                                                                                                                                                                         