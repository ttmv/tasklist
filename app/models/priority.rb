class Priority < ActiveRecord::Base
  has_many :tasks

  validates :value, uniqueness: true

  def to_s
    "#{value} #{description}"
  end

  def maintasks(user)
    tasks.select{|t| t.type == "MainTask" and t.user == user}
  end

  def subtasks(user)
    tasks.select{|t| t.type == "Subtask" and t.user == user}
  end

  def all_tasks(user)
    tasks.select{|t| t.user == user}
  end
end
