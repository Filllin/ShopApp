class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Define the "Categories" variable
  def categories_variable
    @categories = Category.all
  end

  # Return object Product by sort_column
  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  # Return sort_direction
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
