class TasksCategoriesController < ApplicationController
before_action :ensure_that_task_owner

  def create
    @tasks_category = TasksCategory.new(tasks_category_params)
    respond_to do |format|
      if @tasks_category.save
        task = Task.find(params[:tasks_category][:task_id])
        format.html { redirect_to task }
        format.json { render action: 'show', status: :created, location: task }
      end
    end
  end

  def destroy
    @tasks_category = TasksCategory.find(params[:id])
    @tasks_category.destroy
    respond_to do |format|
      format.html { redirect_to :back}
    end
  end

  private

    def ensure_that_task_owner
      task = find_task
 
      if current_user != task.user
        redirect_to :back, notice: "cannot edit task if not a task owner"
      end
    end
  
    def tasks_category_params
      params.require(:tasks_category).permit(:task_id, :category_id)
    end

    def find_task
      if params[:_method] == "delete"
        task = Task.find_by_id(TasksCategory.find_by_id(params[:id]).task_id)       
      else      
        task = Task.find_by_id(params[:tasks_category][:task_id])
      end
    end
end
