class DefaultController < ApplicationController
  def search
    @categories = Category.all
    @search = params[:search].mb_chars.downcase.to_s
    if params[:search].present?
      @products = Product.search(@search)
    end
  end

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
end