class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    session[:view_count] = 0 if session[:view_count].nil?
    session[:view_count] += 1
  end
end
