class CreateDefaultDayTypes < ActiveRecord::Migration
  def self.up
    DayType.create  :name => "Working day",
                    :color => "#BBCCFF",
                    :duration => 8
    DayType.create  :name => "Half day",
                    :color => "#DCBCCF",
                    :duration => 4
    DayType.create  :name => "Holiday",
                    :color => "#FDC68C"
    DayType.create  :name => "Weekend",
                    :color => "#FFFFDD"
  end

  def self.down
    DayType.where(:name => ['Working day', 'Half day', 'Holiday', 'Weekend']).destroy_all
  end
end