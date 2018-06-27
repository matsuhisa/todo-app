class TaskForm
  include ActiveModel::Model

  attr_accessor :title, :description, :user, :team_id, :state
  attr_accessor :begin_at
  attr_accessor :end_at

  def save
    task.build_completion_date(begin_at: begin_at) if begin_at.present?
    task.build_task_due_date(end_at: end_at) if end_at.present?
    task.save
  end

  private

    def task
      @task ||= Task.new(params)
    end

    def params
      { title: title, description: description, user: user, team_id: team_id, state: state }
    end
end
