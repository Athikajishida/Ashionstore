class SubcategoriesController < ApplicationController
    before_action :set_subcategory, only: [:edit, :update, :destroy]
    layout "admin_layouts"

    def new
      @subcategory = Subcategory.new
      @categories = Category.all
    end
  
    def create
      @subcategory = Subcategory.new(subcategory_params)
  
      if @subcategory.save
        redirect_to subcategories_path, notice: 'Subcategory was successfully created.'
      else
        @categories = Category.all
        render :new
      end
    end
  
    def edit
      @categories = Category.all
    end
    def show
        @subcategory = Subcategory.find(params[:id])
      end
      
 
    def update
      if @subcategory.update(subcategory_params)
        redirect_to subcategories_path, notice: 'Subcategory was successfully updated.'
      else
        @categories = Category.all
        render :edit
      end
    end
  
    def destroy
      @subcategory.destroy
      redirect_to subcategories_path, notice: 'Subcategory was successfully destroyed.'
    end
  
    def index
      @subcategories = Subcategory.all
    end
  
    private
  
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end
  
    def subcategory_params
      params.require(:subcategory).permit(:name, :category_id)
    end
end
