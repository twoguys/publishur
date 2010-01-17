class ChangeContactTypeToTypeForSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :type, :string
    Subscription.all.each { |s| s.update_attribute(:type, s.contact_type) }
    remove_column :subscriptions, :contact_type
  end

  def self.down
    add_column :subscriptions, :contact_type, :string
    Subscription.all.each { |s| s.update_attribute(:contact_type, s.type) }
    remove_column :subscriptions, :type
  end
end
