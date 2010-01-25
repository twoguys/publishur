class AddSpreedlyFieldsToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :spreedly_token, :string
    add_column :groups, :spreedly_plan, :string
  end

  def self.down
    remove_column :groups, :spreedly_token
    remove_column :groups, :spreedly_plan
  end
end
