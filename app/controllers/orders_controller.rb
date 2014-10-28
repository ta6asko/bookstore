class OrdersController < ApplicationController
  before_filter :authenticate_user!, except => [:show, :index]
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
