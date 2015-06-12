class AuthorController < ApplicationController
  before_action :categories_variable
  helper_method :sort_column, :sort_direction

  # Return the products by author
  def view_author
    @author = Author.find_by_slug(params[:slug])
    not_found(@author)
    if params[:count].present?
      @products = Author.count_products(params[:count], @author, params[:page], sort_column, sort_direction)
      flash.now[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      @products = Author.count_products(10, @author, params[:page], sort_column, sort_direction)
    end
  end
end