class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :load_subcategories2, only: [:new, :create, :edit, :update]
    layout "admin_layouts"

    def index
      ActiveStorage::Current.url_options = { host: request.base_url }
      @products = Product.all
    end
 
    def show
    end

    def new
      @product = Product.new
      respond_to do |format|
        format.html # Render the HTML template (default behavior)
        format.json { render json: { subcategories: @subcategories } } # Respond with JSON for AJAX requests
      end
    end
 
    def create
      # Remove the empty string or set it to nil
      params[:product][:subcategory_id] = nil if params[:product][:subcategory_id].blank?
      create_price_combinations(@product, params[:product])
      @product = Product.new(product_params)

    
      if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
      else
        render :new
      end
    end
    




    def edit

      end 
      def update
        @product = Product.find(params[:id])      
        if @product.update(product_params)
          redirect_to @product, notice: 'Product was successfully updated.'
        else
          render :edit
        end
      end
      def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_url, notice: 'Product was successfully destroyed.'
      end
    
    def load_subcategories
      @categories = Category.all
      @sizes = Size.all
      @colors = Color.all
      @subcategories = Subcategory.where(category_id: params[:id])
      render json: @subcategories

    end
    private
    def load_subcategories2
      @categories = Category.all
      @sizes = Size.all
      @colors = Color.all
      @subcategories = Subcategory.where(category_id: params[:id])
    
      respond_to do |format|
        format.html
        format.json { render json: { subcategories: @subcategories } }
      end   
    end 
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :subcategory_id, :size_id, :color_id, :image)
    end
    def create_price_combinations(product, variant_params)

      self.prices.create(variant_params['variants_attributes'])
 
      variants.each do |variant|
        color_id = variant['color_id']
        size_id = variant['size_id']
        price = variant['price']
        quantity = variant['quantity']
    
        Price.create(product: product, color_id: color_id, size_id: size_id, price: price, quantity: quantity)
      end
    end
    
end
