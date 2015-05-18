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

  def view_product
    @product = Product.where(slug: params[:slug])
    @product.each do |product|
       @title = product.title
    end
    if params[:count_of_products].present?
    respond_to do |format|
      format.html { redirect_to view_product_path, notice: "Товар #{@title} добавлен в корзину" }
      end
    end
  end
end