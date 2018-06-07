class CreateDueDates < ActiveRecord::Migration[5.1]
  def change
    create_table :due_dates do |t|
      t.belongs_to :task, index: true, null: false
      t.datetime :close_at, null: false

      t.timestamps
    end
  end
end
