class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    session[:view_count] = 0 if session[:view_count].nil?
    session[:view_count] += 1
  end
end
