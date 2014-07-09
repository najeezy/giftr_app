class User < ActiveRecord::Base
  has_secure_password

  validates :username, :first_name, :password, :password_confirmation, :last_name, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 8 }
end
