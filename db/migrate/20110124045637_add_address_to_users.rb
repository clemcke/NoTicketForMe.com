class AddAddressToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :address1
    remove_column :users, :address2
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zipcode
  end
end
