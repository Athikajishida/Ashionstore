class WelcomeController < ApplicationController
  layout "user_layouts" 
  def index
    Cart.where(user_id: current_user).first_or_create
  end
end
