class Report < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :date, :code, :notes, :user

  def validate
    errors.add(:date, "can't be before account creation") if user.created_at.to_date > date
    errors.add(:date, "can't be in the future") if date > Date.today
    errors.add(:code, "can't be your code") if code == user.code
    errors.add(:code, "can't find user code") unless u = User.find_by_code(code)
    errors.add(:code, "that user has not yet activated his/her account") unless u.activated?
  end
end
