class Priority < ActiveRecord::Base
  has_many :tasks

  validates :value, uniqueness: true
  validates :value, presence: true

  def to_s
    "#{value} #{description}"
  end

  def maintasks(user)
    tasks.unfinished.select{|t| t.type == "MainTask" and t.user == user}
  end

  def subtasks(user)
    tasks.unfinished.select{|t| t.type == "Subtask" and t.user == user}
  end

  def all_tasks(user)
    tasks.unfinished.select{|t| t.user == user}
  end
end
