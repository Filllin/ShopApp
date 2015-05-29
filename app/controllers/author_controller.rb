class AuthorController < ApplicationController
  helper_method :sort_column, :sort_direction

  def view_author
    @categories = Category.all
    if params[:count].present?
      @products = Author.count_products(params[:count], params[:slug], params[:page], sort_column, sort_direction)
      flash[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      @products = Author.count_products(10, params[:slug], params[:page], sort_column, sort_direction)
    end
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end