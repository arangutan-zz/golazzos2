class AddUsedToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :used, :boolean, default: false
  end
end
