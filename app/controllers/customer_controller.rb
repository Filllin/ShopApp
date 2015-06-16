class CustomerController < ApplicationController
  before_action :categories_variable, :search, only: [:cart, :new, :review]

  # Return cart page
  def cart
    @orders = Order.where(user_session_id: session['session_id'])
  end

  # Destroy product by customer
  def destroy
    Order.destroy_product(params[:product_title], params[:quantity_of_products], session['session_id'])
    redirect_to cart_path, notice: "Вы убрали из корзины #{params[:product_title]}"
  end

  # Update quantity products by customer
  def update_quantity
    product = Product.find_by_title(params[:product_title])
    order = Order.find_by(user_session_id: session['session_id'], product: product, customer: nil)
    if params[:quantity_of_products].present? && params[:product_title].present?
      if product.quantity_products + order.quantity  >= params[:quantity_of_products].to_i
        Order.update_quantity_product(order, product, params[:quantity_of_products])
        redirect_to cart_path, notice: "Количество товара #{params[:product_title]} было обновлено до #{params[:quantity_of_products]}"
      else
        redirect_to cart_path, notice: "Простите, вы не можите купить этот товар количеством в #{params[:quantity_of_products].to_i} так как их всего #{product.quantity_products}"
      end
    end
  end

  # Return new object customer
  def new
    @orders = Order.where(user_session_id: session['session_id'])
    @customer = Customer.new
  end

  # Update object Order
  def create
    exist_customer = Order.find_exist_customer(
                      customer_params[:name],
                      customer_params[:surname],
                      customer_params[:phone_number],
                      customer_params[:country],
                      customer_params[:company],
                      customer_params[:first_address],
                      customer_params[:second_address],
                      customer_params[:city],
                      customer_params[:state],
                      customer_params[:postcode],
                      customer_params[:email]
                     )
    if exist_customer.present?
      customer = exist_customer
    else
      customer = Customer.create(customer_params)
    end
      coupon = Coupon.find_by_code(params[:coupon])
      Order.where(user_session_id: session['session_id']).update_all(coupon_id: coupon, customer_id: customer, user_session_id: nil)
      SendMailer.customer_email(customer, Order.where(customer: customer), coupon).deliver_now
      SendMailer.admin_email(customer, Order.where(customer: customer), coupon).deliver_now
      redirect_to root_path, notice: 'Ваш заказ успешно принят'
  end

  # Return review page with all information about product and customer
  def review
    @customer = Customer.new(customer_params)
    if @customer.invalid?
      respond_to do |format|
        @orders = Order.where(user_session_id: session['session_id'])
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
    end
    @orders = Order.where(user_session_id: session['session_id'])
    if params[:coupon].present?
      @coupon = Coupon.find_by_code(params[:coupon])
      Order.update_total_price(@orders, @coupon)
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :surname, :phone_number, :country, :company, :first_address, :second_address, :city, :state, :postcode, :email, :email_confirmation, :email_confirmation)
    end
end