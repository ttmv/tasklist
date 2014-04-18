class Task < ActiveRecord::Base
  belongs_to :user
  has_many :tasks_categories
  has_many :categories, through: :tasks_categories

  validates :name, presence: true

  def task_category(category)
    TasksCategory.where(category_id: category ).where(task_id: self.id ).first.id
  end

  def excluded_categories
     Category.all.select{ |c| !c.tasks.include? self }
  end
end
