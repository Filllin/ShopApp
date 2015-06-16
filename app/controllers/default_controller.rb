class DefaultController < ApplicationController
  before_action :categories_variable, :search

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