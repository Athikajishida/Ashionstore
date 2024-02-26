class WishlistsController < ApplicationController
    before_action :authenticate_user! 
    layout "user_layouts" 
    skip_before_action :verify_authenticity_token, only: [:create]

    def index
      @wishlists = current_user.wishlists
    end
  
    def create
      @wishlist = current_user.wishlists.build(product_id: params[:product_id])
  
      if @wishlist.save
        render json: { success: true, count: current_user.wishlists.count }
      else
        render json: { success: false, errors: @wishlist.errors.full_messages }
      end
    end
  
    def destroy
      @wishlist = current_user.wishlists.find(params[:id])
  
      if @wishlist.destroy
        flash[:notice] = 'Product removed from wishlist successfully.'
      else
        flash[:alert] = 'Failed to remove product from wishlist.'
      end
  
      redirect_back(fallback_location: root_path)
    end
  
    private
  
    def wishlist_params
      params.require(:wishlist).permit(:product_id).merge(user_id: current_user.id)
    end
  end
  