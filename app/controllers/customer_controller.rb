class CustomerController < ApplicationController
  def cart
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
  end

  def destroy
    CustomerProduct.destroy_product(params[:product_title], params[:quantity_of_products], session['session_id'])
    redirect_to cart_path, notice: "Вы убрали из корзины #{params[:product_title]}"
  end

  def update_quantity
    if params[:quantity_of_products].present? && params[:product_title].present?
      product = Product.find_by_title(params[:product_title])
      customer_product = CustomerProduct.where(user_session_id: session['session_id'], product: product).first
      if params[:quantity_of_products].to_i < customer_product.quantity
        quantity_products = product.quantity_products + (customer_product.quantity - params[:quantity_of_products].to_i)
      else
        quantity_products = product.quantity_products - (params[:quantity_of_products].to_i - customer_product.quantity)
      end
      product.update(quantity_products: quantity_products)
      customer_product.update(quantity: params[:quantity_of_products])
      respond_to do |format|
        format.html { redirect_to cart_path, notice: "Количество товара #{params[:product_title]} было обновлено до #{params[:quantity_of_products]}" }
        format.json { head :no_content }
      end
    end
  end

  def new
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
    @customer = Customer.new
  end

  def create
    customer = Customer.new(customer_params)
    respond_to do |format|
      if customer.save
        CustomerProduct.where(user_session_id: session['session_id']).update_all(customer_id: customer, user_session_id: nil)
        SendMailer.customer_email(customer, CustomerProduct.where(customer: customer)).deliver_now
        SendMailer.admin_email(customer, CustomerProduct.where(customer: customer)).deliver_now
        format.html { redirect_to root_path, notice: 'Ваш заказ успешно принят' }
      else
        format.html { redirect_to root_path }
      end
    end
  end

  def review
    @customer = Customer.new(customer_params)
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :surname, :phone_number, :bonuses, :country, :company, :first_address, :second_address, :city, :region, :postcode, :email)
    end
end