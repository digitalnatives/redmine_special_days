class CreatePocketCalendars < ActiveRecord::Migration
  def change
    create_table :pocket_calendars do |t|
      t.string  :name
      t.integer :week_pattern_id
    end

    add_index :pocket_calendars, :name, :unique => true
  end
end