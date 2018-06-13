class CreateTaskDueDates < ActiveRecord::Migration[5.1]
  def change
    create_table :task_due_dates do |t|
      t.belongs_to :task, index: true, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
