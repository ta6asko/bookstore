class BillingAddressesController < ApplicationController
  before_action :set_billing_address, only: [:show, :edit, :update, :destroy]

  def index
    @billing_addresses = BillingAddress.all
    
  end

  def show

  end

  def new
    @billing_address = BillingAddress.new
  end

  def edit
  end

  def create
    @billing_address = BillingAddress.new(billing_address_params)
    @billing_address.save
  end

  def update
    @billing_address.update(billing_address_params)
  end

  def destroy
    @billing_address.destroy
    respond_with(@billing_address)
  end

  private
    def set_billing_address
      @billing_address = BillingAddress.find(params[:id])
    end

    def billing_address_params
      params[:billing_address]
    end
end
