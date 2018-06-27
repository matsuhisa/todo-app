class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task_form = TaskForm.new(Task.new)
  end

  def edit
    @task_form = TaskForm.new(@task, @task.form_params)
  end

  def create
    @task_form = TaskForm.new(Task.new, task_form_params.merge(user: current_user))

    if @task_form.create
      redirect_to @task_form.task, notice: 'task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task_form = TaskForm.new(@task, task_form_params.merge(user: current_user))

    if @task_form.update
      redirect_to @task_form.task, notice: 'task was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_form_params
    params.require(:task_form).permit(:title, :description, :end_at, :begin_at, :team_id, :state)
  end
end
