class SubtasksController < TasksController
  def new    
    @task = Subtask.new
    @task.main_task_id = params[:format]
    @categs = Category.all
    @maintasks = current_user.main_tasks
  end

  private

    def task_params
      params.require(:subtask).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id, :priority_id)
    end

    def done_tasks
      current_user.subtasks.finished
    end

    def tasks
      current_user.subtasks.unfinished
    end

    def priority_tasks
      current_user.subtasks.unfinished.includes(:priority).order("priorities.value")
    end

end
