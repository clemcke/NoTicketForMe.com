class Activation < ActiveRecord::Base
  belongs_to :user

  def set_status_as_new
    self.status = "new"
  end

  def set_status_as_in_progress
    self.status = "in_progress"
  end

  def activate!(paypal_transaction)
    self.paypal_transaction = paypal_transaction
    self.activated_at = Time.now
    self.status = "completed"
    self.save!
  end
end
