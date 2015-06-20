class CategoryController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return products by category
  def view_category
    @category = Category.find_by_slug(params[:slug])
    not_found(@category)
    if params[:count].present?
      count = params[:count]
    else
      count = 10
    end
    main_category = @category.subcategories
    if main_category.blank?
      main_category = @category
    end
    @products = Product.count_products_by_category(main_category, count, params[:page], sort_column, sort_direction)
  end
end