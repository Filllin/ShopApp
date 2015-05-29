class CategoryController < ApplicationController
  helper_method :sort_column, :sort_direction

  def view_category
    @categories = Category.all
    slug_category = Category.where(slug: params[:slug])
    if params[:count].present?
      @products = Product.count_products_by_category(slug_category, params[:count], params[:page], sort_column, sort_direction)
    else
      @products = Product.count_products_by_category(slug_category, 10, params[:page], sort_column, sort_direction)
    end
  end

  def view_sub_category
    @categories = Category.all
    if params[:count].present?
      @products = Product.count_products_by_sub_category(params[:slug], params[:count], params[:page], sort_column, sort_direction)
    else
      @products = Product.count_products_by_sub_category(params[:slug], 10, params[:page], sort_column, sort_direction)
    end
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end