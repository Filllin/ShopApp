class PublisherController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return products by publisher
  def view_publisher
    @categories = Category.all
    if params[:count].present?
      @products = Publisher.count_products(params[:count], params[:slug], params[:page], sort_column, sort_direction)
      flash[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      @products = Publisher.count_products(10, params[:slug], params[:page], sort_column, sort_direction)
    end
  end
end