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
      CustomerProduct.update_quantity_product(params[:product_title], params[:quantity_of_products], session['session_id'])
      redirect_to cart_path, notice: "Количество товара #{params[:product_title]} было обновлено до #{params[:quantity_of_products]}"
    end
  end

  def new
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
    @customer = Customer.new
  end

  def create
    customer = Customer.new(customer_params)
      if customer.save
        CustomerProduct.where(user_session_id: session['session_id']).update_all(customer_id: customer, user_session_id: nil)
        SendMailer.customer_email(customer, CustomerProduct.where(customer: customer)).deliver_now
        SendMailer.admin_email(customer, CustomerProduct.where(customer: customer)).deliver_now
        redirect_to root_path, notice: 'Ваш заказ успешно принят'
      else
        redirect_to root_path
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