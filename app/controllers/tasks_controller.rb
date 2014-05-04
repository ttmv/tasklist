class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:show, :new, :edit, :create, :update]
  before_action :ensure_that_signed_in
  before_action :set_priorities


  # GET /tasks
  # GET /tasks.json
  def index
    @done_tasks = current_user.main_tasks.finished
    @tasks = current_user.main_tasks.unfinished

    order = params[:order] || 'date'
    
    case order
      when 'name' then @tasks.sort_by!{ |t| t.name }
      when 'date' then @tasks.sort_by!{ |t| t.date }
      when 'type' then @tasks.sort_by!{ |t| t.type }
      when 'priority' then @tasks = current_user.main_tasks.unfinished.includes(:priority).order("priorities.value")
    end    
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @tasks_category = TasksCategory.new
  end

  # GET /tasks/new
  def new
    @task = MainTask.new
  end

  # GET /tasks/1/edit
  def edit
    @maintasks = current_user.main_tasks
  end

  def mark_done
    task = Task.find(params[:id])
    task.update_attribute(:done, true)
    text = set_done_text(task)

    redirect_to :back, notice: text
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        current_user.tasks << @task

        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy if current_user == @task.user
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end
  
    def set_categories
      @categs = Category.all
    end

    def set_priorities
      @priorities = Priority.all.order(:value)
    end

    def set_done_text(task)
      if task.priority and task.priority.done_text and task.priority.done_text!=""
        text = task.priority.done_text
      else
        text = "task finished!"
      end
    end

    def ensure_that_signed_in
      if current_user.nil?
        redirect_to signin_path, notice: 'Sign in to create new task'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:main_task).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id, :priority_id)
    end
end
