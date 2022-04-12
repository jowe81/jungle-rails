class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count
    @categories = Category.count
    @total_stock = Product.all.reduce(0) do |sum, n|
      sum = sum + n.quantity
    end
  end
end
