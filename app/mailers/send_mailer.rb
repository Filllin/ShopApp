class SendMailer < ActionMailer::Base
  default from: 'friendsboten@gmail.com'

  # Send email to customer with information about order
  def customer_email(user, order, coupon)
    @user = user
    @order = order
    puts order
    @coupon = coupon
    mail(to: @user.email, subject: 'Заказ на FriendsBote')
  end

  # Send email to admin with information about customer and order
  def admin_email(user, order, coupon)
    @user = user
    @order = order
    @coupon = coupon
    mail(to: 'dix.alex@gmail.com', subject: 'Данные о заказе и заказчика с FriendsBote')
  end

  def send_email_about_order_status(status, email)
    @status = status
    mail(to: email, subject: "Order status: #{@status}")
  end
end