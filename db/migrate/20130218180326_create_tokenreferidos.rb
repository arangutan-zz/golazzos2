class CreateTokenreferidos < ActiveRecord::Migration
  def change
    create_table :tokenreferidos do |t|
      t.string :tokenr

      t.timestamps
    end
  end
end
