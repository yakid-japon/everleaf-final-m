class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    # Task.paginate(:page => params[:page], :per_page => 3)
    @tasks = current_user.tasks.order("created_at desc").page(params[:page]).includes(:user)
    @tasks = current_user.tasks.order_by_deadline.page(params[:page]) if params[:sort_expired]
    @tasks = current_user.tasks.order_by_priority.page(params[:page]) if params[:sort_priority]
    if params[:task].present? && params[:task][:tag] == ''
      @tasks = search_by_name_or_status(params[:task][:status], params[:task][:name]).page(params[:page])
    elsif params[:task].present? && params[:task][:tag] != ''
      @tasks = Tag.find_by(id: params[:task][:tag].to_i).tasks
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :content, :deadline, :status, :priority, tag_ids: [])
    end

    def search_by_name_or_status(status, name)
      if status && name == '' 
        @tasks = current_user.tasks.search_by_status(status)
      elsif name && status == ''
        @tasks = current_user.tasks.search_by_name(name.strip)
      end
    end
end
