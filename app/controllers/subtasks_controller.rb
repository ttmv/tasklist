class SubtasksController < TasksController

  def index
    @tasks = Subtask.all
  end 

  def new
    @task = Subtask.new
    @categs = Category.all
    @maintasks = MainTask.all
  end

  private
    def category
      Category.find(params[:subtask][:categories])
    end

    def task_params
      params.require(:subtask).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id)
    end

end
