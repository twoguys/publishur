class AddSendMeUpdatesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :send_me_updates, :boolean, :default => true
  end

  def self.down
    remove_column :users, :send_me_updates
  end
end
