class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :total_usuarios
      t.integer :total_apuestas
      t.decimal :apuestas_usuario
      t.integer :total_referidos
      t.decimal :referidos_usuario
      t.decimal :login_usuario
      t.decimal :posts_usuario
      t.integer :sinapostar_usuarios
      t.integer :sininvitar_usuarios

      t.timestamps
    end
  end
end
