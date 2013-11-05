# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tfp::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  # :address              => "mail.edge-centre.com",
  # :port                 => 7557,
  # :domain               => "edge-centre.com",
  # :user_name            => "support@edge-centre.com",
  # :password             => "Support!23",
  # :authentication       => "plain",
  # :openssl_verify_mode  => 'none',
  # :enable_starttls_auto => true
  

  # :address              => 'mail.rasoiclub.com',
  # :domain               => 'mail.rasoiclub.com',
  # :port                 => 25,
  # :user_name            => 'contact@rasoiclub.com',
  # :password             => 'c0ntact123',
  # :enable_starttls_auto => false,
  # :authentication       => "plain"
  
  :address              => 'mail.edgepedia.in',
  :domain               => 'mail.edgepedia.in',
  :port                 => 25,
  :user_name            => 'support@edgepedia.in',
  :password             => 'supp0rt@123',
#  :enable_starttls_auto => false
  :authentication       => "plain"

 
}