class CartItemsController < ApplicationController
  layout "user_layouts" 
    def show
      ActiveStorage::Current.url_options = { host: request.base_url }
        @cart_item = current_user.cart
      end
      def new_show
        ActiveStorage::Current.url_options = { host: request.base_url }
        @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
    
        if @cart_item.nil?
          redirect_to root_path
        end
      end
    def create
      @cart_item = current_user.cart.cart_items.build(cart_item_params)
      if @cart_item.save
      else
      end
    end
 
    def update
      @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
  
      if @cart_item
        if @cart_item.update(cart_item_params)
        else
        end
      else
        redirect_to root_path
      end
    end
    def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
       cart_total = calculate_cart_total(current_user.cart)
      render json: { success: true, cart_total: cart_total }
    end 
    private
  
  
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end
  end