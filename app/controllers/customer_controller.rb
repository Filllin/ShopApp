class CustomerController < ApplicationController
  # Return cart page
  def cart
    @order = Order.find_by(user_session_id: session['session_id'])
  end

  # Destroy product by customer
  def destroy
    OrderItem.find_by(product: Product.find_by_title(params[:product_title]))
             .destroy_product(params[:quantity_of_products])
    redirect_to cart_path, notice: "Вы убрали из корзины #{params[:product_title]}"
  end

  # Update quantity products by customer
  def update_quantity
    product = Product.find_by_title(params[:product_title])
    order_item = OrderItem.find_by_product(product)
    if params[:quantity_of_products].present? && product.present?
      if product.quantity_products + order_item.quantity  >= params[:quantity_of_products].to_i
        order_item.update_quantity_product(params[:quantity_of_products])
        redirect_to cart_path, notice: "Количество товара #{params[:product_title]} было обновлено до #{params[:quantity_of_products]}"
      else
        redirect_to cart_path, notice: "Простите, вы не можите купить этот товар количеством в #{params[:quantity_of_products].to_i} так как их всего #{product.quantity_products}"
      end
    end
  end

  # Return new object customer
  def new
    @order = Order.find_by_user_session_id(session['session_id'])
    @customer = Customer.new
  end

  # Update object Order
  def create
    exist_customer = Customer.find_by(customer_params_without_email_confirmation)
    if exist_customer.present?
      customer = exist_customer
    else
      customer = Customer.create(customer_params)
    end
      coupon = Coupon.find_by_code(params[:coupon])
      Order.find_by_user_session_id(session['session_id'])
           .update(customer: customer, coupon: coupon, user_session_id: nil)
      SendMailer.customer_email(customer, Order.where(customer: customer), coupon).deliver_now
      SendMailer.admin_email(customer, Order.where(customer: customer), coupon).deliver_now
      redirect_to root_path, notice: 'Ваш заказ успешно принят'
  end

  # Return review page with all information about product and customer
  def review
    @customer = Customer.new(customer_params)
    @order = Order.find_by_user_session_id(session['session_id'])
    if @customer.invalid?
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
    end
    Coupon.all.find_each do |coupon|
     if params[:coupon] == coupon.code
       @present_coupon = true
     end
    end
    if params[:coupon].present? && @present_coupon == true
      @coupon = Coupon.find_by_code(params[:coupon])
      @order.update_total_price_cents(@coupon)
    else
      @order.update_total_price_cents(nil)
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :surname, :phone_number, :country, :company, :first_address, :second_address, :city, :state, :postcode, :email, :email_confirmation)
    end

    def customer_params_without_email_confirmation
      params.require(:customer).permit(:name, :surname, :phone_number, :country, :company, :first_address, :second_address, :city, :state, :postcode, :email)
    end
end