class AddApostariaToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :apostaria, :boolean
  end
end
