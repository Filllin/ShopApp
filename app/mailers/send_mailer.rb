class SendMailer < ActionMailer::Base
  default from: 'friendsboten@gmail.com'

  def customer_email(user,orders, coupon)
    @user = user
    @orders = orders
    @coupon = coupon
    mail(to: @user.email, subject: 'Заказ на FriendsBote')
  end

  def admin_email(user, orders, coupon)
    @user = user
    @orders = orders
    @coupon = coupon
    mail(to: 'dix.alex@gmail.com', subject: 'Данные о заказе и заказчика с FriendsBote')
  end

  def send_email_about_order_status(status, email)
    @status = status
    mail(to: email, subject: "Order status: #{@status}")
  end

end