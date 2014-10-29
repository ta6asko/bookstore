class ShippingAddressesController < ApplicationController
  before_action :set_shipping_address, only: [:show, :edit, :update, :destroy]

  def index
    @shipping_addresses = ShippingAddress.all
    respond_with(@shipping_addresses)
  end

  def show
    respond_with(@shipping_address)
  end

  def new
    @shipping_address = ShippingAddress.new
    respond_with(@shipping_address)
  end

  def edit
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.save
    respond_with(@shipping_address)
  end

  def update
    @shipping_address.update(shipping_address_params)
    respond_with(@shipping_address)
  end

  def destroy
    @shipping_address.destroy
    respond_with(@shipping_address)
  end

  private
    def set_shipping_address
      @shipping_address = ShippingAddress.find(params[:id])
    end

    def shipping_address_params
      params[:shipping_address]
    end
end
