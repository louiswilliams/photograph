class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :name, :email, :phone, :password, :password_confirmation, :remember_me, :login
  attr_accessor :login
  # attr_accessible :login
  has_many :posts
  has_many :likes
  validates :phone, :uniqueness => true, :presence => true,
    format: { with: /\(?\d{3}\)?-?\d{3}-?\d{4}/, message: "Bad phone format"}

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
        where(conditions).where(["lower(email) = :value OR phone = :value",
            {:value => login.downcase }]).first
    else
        where(conditions).first
    end
  end

end
