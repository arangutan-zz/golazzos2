class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :nombre
      t.string :pais
      t.string :ciudad
      t.string :direccion
      t.string :email
      t.string :celular
      t.string :twitter
      t.string :equipos_favoritos
      t.string :camiseta_de
      t.string :talla
      t.integer :num_visitas, default: 0
      t.timestamps
    end
  end
end
