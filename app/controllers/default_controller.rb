class DefaultController < ApplicationController
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
end