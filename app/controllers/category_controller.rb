class CategoryController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return products by category
  def view_category
    @categories = Category.all
    @category = Category.find_by_slug(params[:slug])
    if params[:count].present?
      @products = Product.count_products_by_category(@category, params[:count], params[:page], sort_column, sort_direction)
    else
      @products = Product.count_products_by_category(@category, 10, params[:page], sort_column, sort_direction)
    end
  end

  # Return products by sub_category
  def view_sub_category
    @sub_category = SubCategory.find_by_slug(params[:slug])
    @categories = Category.all
    if params[:count].present?
      @products = Product.count_products_by_sub_category(@sub_category, params[:count], params[:page], sort_column, sort_direction)
    else
      @products = Product.count_products_by_sub_category(@sub_category, 10, params[:page], sort_column, sort_direction)
    end
  end
end