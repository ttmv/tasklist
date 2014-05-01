class SubtasksController < TasksController

  def index
    @tasks = current_user.subtasks
  end 

  def new
    @task = Subtask.new
    @categs = Category.all
    @maintasks = current_user.main_tasks
  end

  private
    def category
      Category.find(params[:subtask][:categories])
    end

    def task_params
      params.require(:subtask).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id, :priority_id)
    end

end
