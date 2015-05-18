class PublisherController < ApplicationController
  helper_method :sort_column, :sort_direction

  def view_publisher
    if params[:count].present?
      @products = Product.where(publisher: Publisher.where(slug: params[:slug])).order(sort_column + " " + sort_direction).paginate(:per_page => params[:count], :page => params[:page])
      respond_to do |format|
        format.html { redirect_to view_publisher_path, notice: "Вам будет показано #{params[:count]} товаров" }
      end
    else
      @products = Product.where(publisher: Publisher.where(slug: params[:slug])).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    end
    @categories = Category.all
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end