ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              => "friendsbottom.gmail.com",
    :port                 => 25,
    :domain               => "gmail.com",
    :user_name            => "example@friendsbote.herokuapp.com",
    :password             => ENV['SMTP_PASSWORD'],
    :authentication       => "plain",
    :enable_starttls_auto => true
}

ActionMailer::Base.raise_delivery_errors = true