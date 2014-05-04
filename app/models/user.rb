class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :main_tasks, dependent: :destroy
  has_many :subtasks, dependent: :destroy

  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
end
