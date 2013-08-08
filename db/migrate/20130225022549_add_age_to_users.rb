class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :email, :string
  end
end
