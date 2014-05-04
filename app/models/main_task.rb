class MainTask < Task
  has_many :subtasks, dependent: :destroy
  belongs_to :user
end
