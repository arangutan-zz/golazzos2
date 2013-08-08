class AddInvitationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_number, :integer, default: 0
  end
end
