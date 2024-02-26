class CartsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @cart = current_user.cart
    end
  
    def add_to_cart
      @product = Product.find(params[:product_id])
      @cart_item = current_user.cart.cart_items.find_or_initialize_by(product: @product)
      @cart_item.quantity += 1
      @cart_item.save
      redirect_to @product, notice: 'Product added to cart successfully.'
    end
  
    def apply_coupon
      coupon_code = params[:coupon_code]
      coupon = Coupon.find_by(code: coupon_code)
  
      if coupon
        updated_total = calculate_updated_total(current_user.cart.total, coupon.discount_percentage)
  
        render json: { success: true, total: updated_total }
      else
        render json: { success: false }
      end
    end
  
    private
  
    def calculate_updated_total(current_total, discount_percentage)
      updated_total = current_total - (current_total * (discount_percentage / 100.0))
      updated_total.round(2)
    end  
  end
  