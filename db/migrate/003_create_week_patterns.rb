class CreateWeekPatterns < ActiveRecord::Migration
  def change
    create_table :week_patterns do |t|
      t.string :name
      t.text   :days
    end

    add_index :week_patterns, :name, :unique => true
  end
end