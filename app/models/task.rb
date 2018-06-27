class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :state, presence: true

  has_one :task_due_date
  has_one :completion_date
  belongs_to :user
  belongs_to :team

  accepts_nested_attributes_for :task_due_date
  accepts_nested_attributes_for :completion_date

  enum state: { registered: 0, assigned: 1, completed: 2 }

  def form_params
    {
      title: title,
      description: description,
      state: state,
      user: user,
      team_id: team_id,
      end_at: task_due_date&.end_at,
      begin_at: completion_date&.begin_at
    }
  end
end
