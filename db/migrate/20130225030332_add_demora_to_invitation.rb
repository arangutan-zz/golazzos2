class AddDemoraToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :demora, :decimal
  end
end
