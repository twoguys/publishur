class FixGroupMembershipStates < ActiveRecord::Migration
  def self.up
    remove_column :group_memberships, :accepted
    add_column :group_memberships, :state, :string
    GroupMembership.all.each do |gm|
      gm.update_attribute(:state, "member")
    end
  end

  def self.down
    add_column :group_memberships, :accepted, :boolean, :default => true
    remove_column :group_memberships, :state
  end
end
