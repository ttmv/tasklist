class Category < ActiveRecord::Base
  has_many :tasks_categories
  has_many :tasks, through: :tasks_categories

  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
