class TasksController < ApplicationController
  before_action :set_task, only: :show

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
    @teams = current_user.teams
  end

  def create
    @task = Task.new task_params.merge(user: current_user)

    if @task.save
      redirect_to @task, notice: 'task was successfully created.'
    else
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :team_id, :state)
  end
end
