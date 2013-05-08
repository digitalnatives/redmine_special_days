class CreateSpecialDays < ActiveRecord::Migration
  def change
    create_table :special_days do |t|
      t.integer :pocket_calendar_id
      t.integer :day_type_id
      t.date    :date
      t.string  :description
    end

    add_index :special_days, :pocket_calendar_id
    add_index :special_days, [:pocket_calendar_id, :date]
    add_index :special_days, [:date, :pocket_calendar_id]
  end
end