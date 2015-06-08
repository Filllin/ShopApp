class SendMailer < ActionMailer::Base
  default from: 'friendsboten@gmail.com'

  def customer_email(user,customers_product, coupon)
    @user = user
    @customers_product = customers_product
    @coupon = coupon
    mail(to: @user.email, subject: 'Заказ на FriendsBote')
  end

  def admin_email(user, customers_product, coupon)
    @user = user
    @customers_product = customers_product
    @coupon = coupon
    mail(to: 'dix.alex@gmail.com', subject: 'Данные о заказе и заказчика с FriendsBote')
  end
end