chelass CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.date :date
      t.string :code
      t.text :notes
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
