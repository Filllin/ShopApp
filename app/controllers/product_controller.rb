class ProductController < ApplicationController
  def view_product
    @product = Product.find_by_slug(params[:slug])
    @title = @product.title
    if params[:count_of_products].present?
      customer_product = CustomerProduct.find_by(user_session_id: session['session_id'], product: @product, customer: nil)
      if customer_product.present?
          @quantity = params[:count_of_products].to_i + customer_product.quantity
          customer_product.update(quantity: @quantity)
      else
          CustomerProduct.create(user_session_id: session['session_id'], product: @product, quantity: params[:count_of_products])
      end
      if @product.quantity_products >= params[:count_of_products].to_i
        @quantity_products = @product.quantity_products - params[:count_of_products].to_i
        @product.update(quantity_products: @quantity_products)
        respond_to do |format|
          format.html { redirect_to view_product_path, notice: "Товар #{@title} добавлен в корзину" }
        end
      else
        respond_to do |format|
          format.html { redirect_to view_product_path, notice: "Простите, вы не можите купить этот товар количеством в #{params[:count_of_products].to_i} так как их всего #{@product.quantity_products}" }
        end
      end
    end
  end
end