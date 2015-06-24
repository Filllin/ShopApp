class AuthorController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return the products by author
  def view_author
    @author = Author.find_by_slug(params[:slug])
    not_found(@author)
    count = params[:count]
    if count.present?
      flash.now[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      count = 1
    end
    @products = @author.count_products(count, params[:page], sort_column, sort_direction)
  end
end