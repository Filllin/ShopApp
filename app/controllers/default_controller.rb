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

  # Return contacts page
  def contacts
    @contacts = Contact.first
  end

  # Return about page
  def about
    @about = About.first
  end

  # Return payment page
  def payment
    @payment = Payment.first
  end
end