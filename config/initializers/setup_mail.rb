ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => "example@n3wnormal.com",
    :password             => "passwordforemail",
    :authentication       => "plain",
    :enable_starttls_auto => true
}

ActionMailer::Base.raise_delivery_errors = true