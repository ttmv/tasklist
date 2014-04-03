class User < ActiveRecord::Base
  has_many :tasks
  has_many :main_tasks
  has_many :subtasks

  has_secure_password

  validates :username, presence: true
end
