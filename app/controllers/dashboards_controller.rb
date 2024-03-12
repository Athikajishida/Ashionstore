class DashboardsController < ApplicationController
    layout "admin_layouts"
    def index
      @total_customers = User.count
      @total_sales = Order.count
      @total_revenue = Order.sum(:discounted_total)
      @number_of_products = Product.count
    end
  end
  