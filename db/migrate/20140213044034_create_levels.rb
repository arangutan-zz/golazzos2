class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :title
      t.integer :min_experience
      t.integer :max_experience

      t.timestamps
    end
  end
end
