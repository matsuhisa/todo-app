class CreateTeamDueDates < ActiveRecord::Migration[5.1]
  def change
    create_table :team_due_dates do |t|
      t.belongs_to :team, index: true, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
