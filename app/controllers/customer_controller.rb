class CustomerController < ApplicationController

  # Return cart page
  def cart
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
  end

  # Destroy product by customer
  def destroy
    CustomerProduct.destroy_product(params[:product_title], params[:quantity_of_products], session['session_id'])
    redirect_to cart_path, notice: "Вы убрали из корзины #{params[:product_title]}"
  end

  # Update quantity products by customer
  def update_quantity
    product = Product.find_by_title(params[:product_title])
    customer_product = CustomerProduct.where(user_session_id: session['session_id'], product: product, customer: nil).first
    if params[:quantity_of_products].present? && params[:product_title].present?
      if product.quantity_products + customer_product.quantity  >= params[:quantity_of_products].to_i
        CustomerProduct.update_quantity_product(customer_product, product, params[:quantity_of_products])
        redirect_to cart_path, notice: "Количество товара #{params[:product_title]} было обновлено до #{params[:quantity_of_products]}"
      else
        redirect_to cart_path, notice: "Простите, вы не можите купить этот товар количеством в #{params[:quantity_of_products].to_i} так как их всего #{product.quantity_products}"
      end
    end
  end

  # Return new object customer
  def new
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
    @customer = Customer.new
  end

  # Update object CustomerProduct
  def create
    exist_customer = Customer.find_exist_customer(
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
    ).take
    if exist_customer.present?
      customer = exist_customer
    else
      customer = Customer.create(customer_params)
    end
      coupon = Coupon.find_by_code(params[:coupon])
      CustomerProduct.where(user_session_id: session['session_id']).update_all(coupon_id: coupon, customer_id: customer, user_session_id: nil)
      SendMailer.customer_email(customer, CustomerProduct.where(customer: customer), coupon).deliver_now
      SendMailer.admin_email(customer, CustomerProduct.where(customer: customer), coupon).deliver_now
      redirect_to root_path, notice: 'Ваш заказ успешно принят'
  end

  # Return review page with all information about product and customer
  def review
    @customer = Customer.new(customer_params)
    if @customer.invalid?
      respond_to do |format|
        @categories = Category.all
        @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
    end
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
    if params[:coupon].present?
      @coupon = Coupon.find_by_code(params[:coupon])
      CustomerProduct.update_total_price(@customers_product, @coupon)
    end
    @categories = Category.all
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :surname, :phone_number, :country, :company, :first_address, :second_address, :city, :state, :postcode, :email, :email_confirmation, :email_confirmation)
    end
end