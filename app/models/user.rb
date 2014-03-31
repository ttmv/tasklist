class User < ActiveRecord::Base
  has_many :tasks
  has_secure_password

  validates :username, presence: true
end
