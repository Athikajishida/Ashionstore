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
    @product = Product.new(product_params)
  
    if @product.save
      create_price_combinations(params[:product][:variants_attributes]) if params[:product][:variants_attributes].present?

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
    params.require(:product).permit(:name, :description, :category_id, :subcategory_id, :size_id, :color_id, :image, variants_attributes: [:size_id, :color_id, :price, :quantity])
  end

  def create_price_combinations(variants_attributes)
    variants_attributes.each do |_, variant_params|
      price = @product.prices.new(
        color_id: variant_params[:color_id],
        size_id: variant_params[:size_id],
        price: variant_params[:price],
        quantity: variant_params[:quantity]
      )
      price.save
    end
  end


   
end
