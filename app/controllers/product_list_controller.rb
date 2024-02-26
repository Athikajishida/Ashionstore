class ProductListController < ApplicationController
	  layout "user_layouts" 
    skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

	def index
    ActiveStorage::Current.url_options = { host: request.base_url }

    @products = Product.includes(:variants, :category, :subcategory, :size, :color).all
    @prices = Price.all
    @categories = Category.all
    @sizes = Size.all
    @colors = Color.all
    @subcategories = Subcategory.all
    @cart_item = current_user.cart
    ActiveStorage::Current.url_options = { host: request.base_url }
  end
  def mens
    ActiveStorage::Current.url_options = { host: request.base_url }

    @mens_subcategory = Subcategory.find_by(name: "mens")
    @mens_products = Product.includes(:variants, :category, :subcategory, :size, :color)
                            .where(subcategory: @mens_subcategory)
    @prices = Price.all
    @categories = Category.all
    @sizes = Size.all
    @colors = Color.all
    @subcategories = Subcategory.all
    @cart_item = current_user.cart
    render :mens
   end

  def womens 
    ActiveStorage::Current.url_options = { host: request.base_url }

    @womens_subcategory = Subcategory.find_by(name: "womens")
    @womens_products = Product.includes(:variants, :category, :subcategory, :size, :color)
                              .where(subcategory: @womens_subcategory)
    @prices = Price.all
    @categories = Category.all
    @sizes = Size.all
    @colors = Color.all
    @subcategories = Subcategory.all
    @cart_item = current_user.cart 
    render :womens
  end
  def add_to_cart
    product = Product.find(params[:product_id])
    current_user.cart ||= Cart.create(user: current_user)
    cart_item = current_user.cart.cart_items.find_or_initialize_by(product: product)
    
    cart_item.quantity ||= 0
    cart_item.quantity += 1  
    cart_item.save
  
    render json: { success: true, message: 'Product added to cart successfully' }
  end
  

end
