class Report < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :date, :code, :notes, :user
  before_save :validate_date
  # TODO: validate code before save
  def validate_date
    errors.add(:date, "Can't be before account creation") if date < user.created_at
    errors.add(:date, "Can't be in the future") if date > Date.today
  end
end
