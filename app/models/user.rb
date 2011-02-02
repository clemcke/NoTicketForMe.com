class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :address1, :address2, :city, :state, :zipcode, :phone, :tos_accepted, :email_notification, :over_18, :how_did_you_hear_about_us
  validates_presence_of :first_name, :last_name, :address1, :city, :state, :zipcode
  #validates_acceptance_of :tos_accepted, :over_18
  #validates_acceptance_of :email_notification, :on => :create
  validates_format_of :zipcode, :with => /^(\d{5}|\d{5}\-\d{4})/
  validates_format_of :phone, :with => /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/

  has_many :reports
  has_one :activation

  before_create :generate_code!, :create_activation

  STATES = ["AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "FM", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MH", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "PW", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"]

  def activated?
    activation.status == "completed"
  end

  def activate!(paypal_transaction = nil)
    raise "Already activated" if activated?
    activation.activate!(:paypal_transaction => paypal_transaction)
  end

  def number_of_times_saved
    Report.find_all_by_code(self.code).count
  end

  private
  def generate_code!
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    code = (0...6).map{ charset.to_a[rand(charset.size)] }.join
    generate_code! if User.find_by_code(code)
    self.code = code
  end
end
