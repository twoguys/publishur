class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |t|
      t.string :body
      t.string :class_type
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
