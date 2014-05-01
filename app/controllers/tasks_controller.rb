class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:show, :new, :edit, :create, :update]
#  before_action :ensure_that_signed_in, only: [:new, :edit, :create, :destroy, :update]
  before_action :ensure_that_signed_in
  before_action :set_priorities


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks
    #@tasks = Task.all
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
    #@maintasks = MainTask.all
  end

  def mark_done
    task = Task.find(params[:id])
    task.update_attribute(:done, true)
    text = "task finished!"
    redirect_to :back, notice: text
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.categories << category unless category.nil?    
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
      if !category.nil? and !@task.categories.include?category
        @task.categories << category
      end
 
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
    @task.destroy
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

    def ensure_that_signed_in
      if current_user.nil?
        redirect_to signin_path, notice: 'Sign in to create new task'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:main_task).permit(:name, :date, :done, :type, :info, :main_task_id, :user_id, :priority_id)
    end

    def category 
      if params[:main_task][:categories]    
        Category.find(params[:main_task][:categories])
      end
    end
end
