class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_storage_url_options
  helper_method :calculate_cart_total
  def after_sign_in_path_for(resource)
    admin_index_path
  end
  def calculate_cart_total(cart)
    cart_items_total = cart.cart_items.sum { |item| (item.product.price.to_f * item.quantity.to_i) rescue 0 }
    return cart_items_total
  end
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
  end

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = Rails.application.routes.default_url_options
  end

  def authorize_admin!
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
