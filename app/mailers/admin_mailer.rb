class AdminMailer < ActionMailer::Base

  def admin_email(user)
    @user = user
    mail(to: 'kozeyandrey@gmail.com', subject: 'Данные о заказе и заказчика с FriendsBote')
  end
end