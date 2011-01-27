# Load the rails application
require File.expand_path('../application', __FILE__)

unless RAILS_ENV == 'production'
  PAYPAL_ACCOUNT = "seller_1295625218_biz@gmail.com"
  PAYPAL_URL = "https://sandbox.paypal.com/cgi-bin/webscr"
else
  PAYPAL_ACCOUNT = "info.ntfm@gmail.com"
  PAYPAL_URL = "https://www.paypal.com/cgi-bin/webscr"
end

# Initialize the rails application
Noticketforme::Application.initialize!
