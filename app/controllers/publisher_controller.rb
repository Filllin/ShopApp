class PublisherController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return products by publisher
  def view_publisher
    @publisher = Publisher.find_by_slug(params[:slug])
    not_found(@publisher)
    count = params[:count]
    if count.present?
      flash.now[:notice] = "Вам будет показано #{params[:count]} товаров"
    else
      count = 10
    end
    @products = @publisher.count_products(count, params[:page], sort_column, sort_direction)
  end
end