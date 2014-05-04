class SubtasksController < TasksController

  def index
    @done_tasks = current_user.subtasks.finished
    @tasks = current_user.subtasks.unfinished

    order = params[:order] || 'date'
    
    case order
      when 'name' then @tasks.sort_by!{ |t| t.name }
      when 'date' then @tasks.sort_by!{ |t| t.date }
      when 'type' then @tasks.sort_by!{ |t| t.type }
      when 'priority' then @tasks = current_user.subtasks.unfinished.includes(:priority).order("priorities.value")
    end    
  end 

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

end
