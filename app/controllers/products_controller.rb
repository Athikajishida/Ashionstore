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
    params[:product][:subcategory_id] = nil if params[:product][:subcategory_id].blank?
    create_price_combinations(@product, params[:product])
    @product = Product.new(product_params)
    if @product.save
      variants_attributes = JSON.parse(params[:product][:variants_attributes])
      create_price_combinations(@product, variants_attributes)
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

  def create_price_combinations(product, variants_attributes)
    variants_attributes.each do |variant|
      color_id = variant['color_id']
      size_id = variant['size_id']
      price = variant['price']
      quantity = variant['quantity']
      product.prices.create(color_id: color_id, size_id: size_id, price: price, quantity: quantity)
    end
  end


   
end
