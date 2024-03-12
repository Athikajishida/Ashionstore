class WishlistsController < ApplicationController
    before_action :authenticate_user! 
    layout "user_layouts" 
    skip_before_action :verify_authenticity_token, only: [:create]
    def index
      ActiveStorage::Current.url_options = { host: request.base_url }

      @wishlists = current_user.wishlists
    end
  
    def create
      product_id = params[:product_id]
      existing_wishlist_item = current_user.wishlists.find_by(product_id: product_id)
    
      if existing_wishlist_item
        render json: { success: false, message: "Product is already in your wishlist." }
      else
        @wishlist = current_user.wishlists.build(product_id: product_id)
    
        if @wishlist.save
          render json: { success: true, count: current_user.wishlists.count }
        else
          render json: { success: false, errors: @wishlist.errors.full_messages }
        end
      end
    end
  
    def destroy
      @wishlist = current_user.wishlists.find(params[:id])
    
      if @wishlist.destroy
        render json: { success: true, message: 'Product removed from wishlist successfully.' }
      else
        render json: { success: false, message: 'Failed to remove product from wishlist.' }
      end
    end
  
    private
  
    def wishlist_params
      params.require(:wishlist).permit(:product_id).merge(user_id: current_user.id)
    end
  end
  