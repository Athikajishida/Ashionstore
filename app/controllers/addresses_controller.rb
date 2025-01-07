# frozen_string_literal: true

# Handles CRUD operations for user addresses.
class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :update, :destroy]
  layout "user_layouts"

  def index
    @addresses = current_user.addresses.includes(:city)
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    
    if @address.save
      redirect_to addresses_path, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path, notice: 'Address was successfully removed.'
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to addresses_path, alert: 'Address not found.'
  end

  def address_params
    params.require(:address).permit(:house, :area, :place, :pincode, 
                                  :address_type, :city_id)
  end
end