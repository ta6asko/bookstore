class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]

  def index
    @deliveries = Delivery.all
    respond_with(@deliveries)
  end

  def show
    respond_with(@delivery)
  end

  def new
    @delivery = Delivery.new
    respond_with(@delivery)
  end

  def edit
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.save
    respond_with(@delivery)
  end

  def update
    @delivery.update(delivery_params)
    respond_with(@delivery)
  end

  def destroy
    @delivery.destroy
    respond_with(@delivery)
  end

  private
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def delivery_params
      params[:delivery]
    end
end
