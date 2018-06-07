class CreateUserTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :user_teams do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :team, index: true, null: false
      t.timestamps
    end
    add_index :user_teams, [:user_id, :team_id], unique: true
  end
end
