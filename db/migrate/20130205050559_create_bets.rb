class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :monto
      t.integer :golesLocal
      t.integer :golesVisitante
      t.references :partido
      t.references :user

      t.timestamps
    end
    add_index :bets, :partido_id
    add_index :bets, :user_id
  end
end
