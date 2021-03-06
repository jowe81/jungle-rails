class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV["BASIC_AUTH_USER"], password: ENV["BASIC_AUTH_PASSWORD"]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if (@category.products.count == 0)
      @category.destroy
    end
    redirect_to [:admin, :categories], notice: "Category Deleted!"
    

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end


end
