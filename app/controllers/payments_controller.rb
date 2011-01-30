class PaymentsController < ApplicationController
  protect_from_forgery :except => [:ipn]
  def ipn
    #notify = PaypalNotification.new(params)

    #verify with paypal
    #if notify.acknowledge

    if params["payment_status"] == "Completed"
      begin
        code = params["custom"]
        raise "Invalid user code: #{code}" unless u = User.find_by_code(code)
        u.activate!(:paypal_transaction => params["txn_id"])
      end
    end

    render :nothing => true
  end
end
