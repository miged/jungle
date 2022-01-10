class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }
  validates :password_digest, presence: true
  before_validation :downcase_email

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    @user = User.find_by_email(email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

  private
  def downcase_email
    self[:email].downcase! if self[:email].present?
  end
end
