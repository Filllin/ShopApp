class SendMailer < ActionMailer::Base
  default from: 'friendsboten@gmail.com'

  def customer_email(user,customers_product)
    @user = user
    @customers_product = customers_product
    mail(to: @user.email, subject: 'Заказ на FriendsBote')
  end

  def admin_email(user, customers_product)
    @user = user
    @customers_product = customers_product
    mail(to: 'dix.alex@gmail.com', subject: 'Данные о заказе и заказчика с FriendsBote')
  end
end