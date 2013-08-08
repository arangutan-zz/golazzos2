class AddPosteoToBets < ActiveRecord::Migration
  def change
    add_column :bets, :posteo_fb, :boolean, default: false
  end
end
