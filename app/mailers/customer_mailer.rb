class CustomerMailer < ActionMailer::Base
  default from: 'friendsboten@gmail.com'

  def customer_email(user,customers_product)
    @user = user
    @customers_product = customers_product
    mail(to: @user.email, subject: 'Заказ на FriendsBote')
  end
end