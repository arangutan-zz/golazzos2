class CreateUserLevels < ActiveRecord::Migration
  def change
    create_table :user_levels do |t|
      t.integer :user_id
      t.integer :level_id

      t.timestamps
    end
  end
end
