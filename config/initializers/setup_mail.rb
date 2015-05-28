ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "heroku.com",
    :user_name            => "example@friendsbote.herokuapp.com",
    :password             => ENV['SMTP_PASSWORD'],
    :authentication       => "plain",
    :enable_starttls_auto => true
}

ActionMailer::Base.raise_delivery_errors = true