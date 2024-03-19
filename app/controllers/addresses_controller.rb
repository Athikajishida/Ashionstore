# frozen_string_literal: true

# Handles CRUD operations for user addresses.
class AddressesController < ApplicationController
  before_action :authenticate_user!
  layout 'user_layouts'
  def index
    @addresses = current_user.addresses
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
    @address = current_user.addresses.find(params[:id])
  end

  def update
    @address = current_user.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address = current_user.addresses.find(params[:id])
    @address.destroy

    redirect_to addresses_path, notice: 'Address was successfully destroyed.'
  end

  private

  def address_params
    params.require(:address).permit(:house, :area, :place, :pincode, :address_type, :city_id)
  end
end
