class DefaultController < ApplicationController
  before_action :categories_variable

  # Return search page
  def search
    @search = params[:search].mb_chars.downcase.to_s
    if params[:search].present?
      @products = Product.search(@search)
    end
  end

  # Return home page
  def home
    @products = Product.all
    @count = 20
  end

  # Return static page by slug
  def page
    @page = Page.find_by_slug(params[:slug])
  end
end