class DefaultController < ApplicationController
  def home
    @products = Product.all
    @categories = Category.all
    @count = 20
  end

  def contacts
    @categories = Category.all
    @contacts = Contact.first
  end

  def about
    @about = About.first
    @categories = Category.all
  end

  def payment
    @title = Payment.first.title
    @payment = Payment.first
    @categories = Category.all
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def category_view
    if params[:slug].present?
      @slug_category = Category.where(slug: params[:slug])
      if params[:count].present?
        @products = Product.where(sub_category: SubCategory.where(category: @slug_category)).order(sort_column + " " + sort_direction).paginate(:per_page => params[:count], :page => params[:page])
      else
        @products = Product.where(sub_category: SubCategory.where(category: @slug_category)).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
      end
    end
    @categories = Category.all
  end
end