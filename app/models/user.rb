class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address1, :address2, :city, :state, :zipcode
  validates_presence_of :name, :address1, :city, :state, :zipcode
  validates_format_of :zipcode, :with => /^(\d{5}|\d{5}\-\d{4})/

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
