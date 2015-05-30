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
    if @customer.invalid?
      respond_to do |format|
        @categories = Category.all
        @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
    end
    @categories = Category.all
    @customers_product = CustomerProduct.where(user_session_id: session['session_id'])
  end

  private
    def customer_params
      params.require(:customer).permit(:name, :surname, :phone_number, :bonuses, :country, :company, :first_address, :second_address, :city, :state, :postcode, :email, :email_confirmation)
    end
end