class AddMetricsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_on_fb, :integer, default: 0
    add_column :users, :bets_number, :integer, default: 0
  end
end
