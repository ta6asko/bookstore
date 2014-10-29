class OrdersController < ApplicationController
  include CurrentCart
  before_filter :authenticate_user!, except => [:show, :index]
  before_action :set_cart, only: [:index, :new, :create]
  def index

  end

  def delivery

  end

  def payment

  end

  def confirm

  end

  def complete

  end
  
end
