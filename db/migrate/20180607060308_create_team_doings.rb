class CreateTeamDoings < ActiveRecord::Migration[5.1]
  def change
    create_table :team_doings do |t|
      t.belongs_to :team, index: true, null: false
      t.datetime :close_at, null: false

      t.timestamps
    end
  end
end
