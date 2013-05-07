class CreateDefaultPocketCalendar < ActiveRecord::Migration
  def self.up
    PocketCalendar.create :name => 'Global',
                          :week_pattern => WeekPattern.find_by_name!('Normal week')
  end

  def self.down
    PocketCalendar.where(:name => 'Global').destroy_all
  end
end