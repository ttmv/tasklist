class SubtasksController < TasksController

  def index
    @tasks = current_user.subtasks
  end 

  def new    
    #maintask = MainTask.find(params[:format])
    @task = Subtask.new
    @task.main_task_id = params[:format]
    @categs = Category.all
    @maintasks = current_user.main_tasks
  end

  private
    def category
      if params[:subtask][:categories]
        Category.find(params[:subtask][:categories])
      end
    end

    def task_params
      params.require(:subtask).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id, :priority_id)
    end
end
