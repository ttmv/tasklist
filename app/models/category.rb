class Category < ActiveRecord::Base
  has_many :tasks_categories
  has_many :tasks, through: :tasks_categories

  validates :name, presence: true

  def tasks_of_user(user)
     tasks.unfinished.order(:date).select{|t| t.user == user}
  end

  def to_s
    "#{name}"
  end
end
