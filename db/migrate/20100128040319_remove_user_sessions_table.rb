class RemoveUserSessionsTable < ActiveRecord::Migration
  def self.up
    drop_table :user_sessions
  end

  def self.down
    create_table "user_sessions", :force => true do |t|
      t.string   "email"
      t.string   "password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end   
  end
end
