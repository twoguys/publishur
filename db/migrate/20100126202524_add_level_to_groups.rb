class AddLevelToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :level, :integer, :default => 5
  end

  def self.down
    remove_column :groups, :level
  end
end
