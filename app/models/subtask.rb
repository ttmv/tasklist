class Subtask < Task
  belongs_to :main_task
  belongs_to :user
end
