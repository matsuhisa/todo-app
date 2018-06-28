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
    @task.save
  end

  def update
    task.update(task_params)
  end

  private

  def task_params
    { title: title, description: description, user: user, team_id: team_id, state: state, task_due_date: task_due_date, completion_date: completion_date }
  end

  def task_due_date
    if end_at.present?
      if task.task_due_date
        task.task_due_date.end_at = end_at
        task.task_due_date
      else
        TaskDueDate.new(end_at: end_at)
      end
    end
  end

  def completion_date
    if begin_at.present?
      if task.completion_date
        task.completion_date.begin_at = begin_at
        task.completion_date
      else
        CompletionDate.new(begin_at: begin_at)
      end
    end
  end
end
