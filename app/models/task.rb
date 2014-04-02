class Task < ActiveRecord::Base
  belongs_to :user
  has_many :tasks_categories
  has_many :categories, through: :tasks_categories

  validates :name, presence: true
end
