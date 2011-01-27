class PaymentsController < ApplicationController
  protect_from_forgery :except => [:ipn]
  def ipn
    notify = PaypalNotification.new(params)

    #verify with paypal
    if notify.acknowledge
      begin
        u = User.find_by_email("sixtimesnine@gmail.com")
        u.email = "notified@mail.com"
        u.save!
      end
    end

    render :nothing => true
  end
end
