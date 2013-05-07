class CreateDayTypes < ActiveRecord::Migration
  def change
    create_table :day_types do |t|
      t.string  :name
      t.integer :duration, :default => 0 #hours
      t.string  :color
    end

    add_index :day_types, :name, :unique => true
  end
end