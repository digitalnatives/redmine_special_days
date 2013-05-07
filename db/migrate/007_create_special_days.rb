class CreateSpecialDays < ActiveRecord::Migration
  def change
    create_table :special_days do |t|
      t.integer :calendar_id
      t.integer :day_type_id
      t.date    :date
      t.string  :description
    end

    add_index :special_days, [:calendar_id, :date]
    add_index :special_days, [:date, :calendar_id]
  end
end
