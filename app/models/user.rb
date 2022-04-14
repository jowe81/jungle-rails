class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
