class AddSendAtToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :send_at, :datetime
  end

  def self.down
    remove_column :messages, :send_at
  end
end
