class AuthorController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return the products by author
  def view_author
    @categories = Category.all
    if params[:count].present?
      @products = Author.count_products(params[:count], params[:slug], params[:page], sort_column, sort_direction)
      flash.now[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      @products = Author.count_products(10, params[:slug], params[:page], sort_column, sort_direction)
    end
  end
end