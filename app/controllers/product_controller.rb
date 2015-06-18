class ProductController < ApplicationController
  helper_method :sort_column, :sort_direction

  # Return product by slug and add product to cart
  def view_product
    @product = Product.find_by_slug(params[:slug])
    not_found(@product)
    @title = @product.title
    if params[:count_of_products].present?
      if @product.quantity_products >= params[:count_of_products].to_i
       Product.add_product_to_cart(@product, params[:count_of_products], session['session_id'])
        flash.now[:notice] = "Товар #{@title} добавлен в корзину"
      else
        flash.now[:notice] = "Простите, вы не можите купить этот товар количеством в #{params[:count_of_products].to_i} так как на складе их всего #{@product.quantity_products}"
      end
    end
  end
end