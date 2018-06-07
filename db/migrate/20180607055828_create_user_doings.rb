class CreateUserDoings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_doings do |t|
      t.belongs_to :task, index: true, null: false
      t.datetime :start_at, null: false

      t.timestamps
    end
  end
end
