class AddExperienceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :experience, :integer, default: 0
    add_column :users, :new_level, :boolean, default: true
  end
end
