class AddUserFields < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :tos_accepted, :boolean, :default => false
    add_column :users, :email_notification, :boolean, :default => false
    add_column :users, :over_18, :boolean, :default => false
    add_column :users, :how_did_you_hear_about_us, :text
  end

  def self.down
    add_column :users, :name, :string
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone
    remove_column :users, :tos_accepted
    remove_column :users, :email_notification
    remove_column :users, :over_18, :boolean
    remove_column :users, :how_did_you_hear_about_us
  end
end
