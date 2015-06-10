class DefaultController < ApplicationController

  # Return search page
  def search
    @categories = Category.all
    @search = params[:search].mb_chars.downcase.to_s
    if params[:search].present?
      @products = Product.search(@search)
    end
  end

  # Return home page
  def home
    @products = Product.all
    @categories = Category.all
    @count = 20
  end

  # Return contacts page
  def contacts
    @categories = Category.all
    @contacts = Contact.first
  end

  # Return about page
  def about
    @about = About.first
    @categories = Category.all
  end

  # Return payment page
  def payment
    @payment = Payment.first
    @categories = Category.all
  end
end