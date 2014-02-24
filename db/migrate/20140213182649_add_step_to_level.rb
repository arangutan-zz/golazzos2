class AddStepToLevel < ActiveRecord::Migration
  def change
    add_column :levels, :step, :integer
  end
end
