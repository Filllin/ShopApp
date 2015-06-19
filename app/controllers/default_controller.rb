class DefaultController < ApplicationController
  # Return search page
  def search
    @categories = Category.all
    @search = Product.search(params[:q])
    @products = @search.result.includes(:author, :category)
  end

  # Return home page
  def home
    @products = Product.all
    not_found(@products)
    @count = 20
  end

  # Return static page by slug
  def page
    @page = Page.find_by_slug(params[:slug])
    not_found(@page)
  end
end