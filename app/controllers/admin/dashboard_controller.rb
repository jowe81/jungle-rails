class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["BASIC_AUTH_USER"], password: ENV["BASIC_AUTH_PASSWORD"]

  def show
    @products = Product.count
    @categories = Category.count
    @total_stock = Product.all.reduce(0) do |sum, n|
      sum = sum + n.quantity
    end
  end
end
