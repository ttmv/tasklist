class MainTask < Task
  has_many :subtasks
  belongs_to :user
end
