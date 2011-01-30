class CreateActivations < ActiveRecord::Migration
  def self.up
    create_table :activations do |t|
      t.belongs_to :user
      t.string :status, :default => "new"
      t.string :paypal_transaction
      t.datetime :activated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :activations
  end
end
