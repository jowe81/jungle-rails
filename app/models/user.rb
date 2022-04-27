class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  before_save :downcase_email

  def self.authenticate_with_credentials email, password
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    end
  end

  private

  def downcase_email
    self.email.downcase!
  end

end
