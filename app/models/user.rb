class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def self.authenticate_with_credentials email, password
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    end
  end

end
