class CreateCompletionDates < ActiveRecord::Migration[5.1]
  def change
    create_table :completion_dates do |t|
      t.belongs_to :task, index: true, null: false
      t.datetime :begin_at, null: false

      t.timestamps
    end
  end
end
