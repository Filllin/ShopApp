class DefaultController < ApplicationController
  before_action :categories_variable

  # Return search page
  def search
    if params[:search].present? || params[:sub_category].present?
      search = params[:search].mb_chars.downcase.to_s
      @products = Product.search(search, params[:sub_category])
    end
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