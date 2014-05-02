class TasksCategoriesController < ApplicationController

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
  
    def tasks_category_params
      params.require(:tasks_category).permit(:task_id, :category_id)
    end
end
