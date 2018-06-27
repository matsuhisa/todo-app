class TaskForm
  include ActiveModel::Model

  attr_accessor :title, :description, :user, :team_id, :state, :begin_at, :end_at
  attr_accessor :task

  delegate :persisted?, to: :task

  def initialize(task, attributes = {})
    @task = task
    super(attributes)
  end

  def create
    @task = Task.new(task_params)
    @task.build_completion_date(begin_at: begin_at) if begin_at.present?
    @task.build_task_due_date(end_at: end_at) if end_at.present?
    @task.save
  end

  def update
    task.completion_date = begin_at if begin_at.present?
    task.task_due_date = end_at if end_at.present?
    task.update(task_params)
  end

  private
    def task_params
      { title: title, description: description, user: user, team_id: team_id, state: state }
    end
end
