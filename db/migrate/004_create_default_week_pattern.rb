class CreateDefaultWeekPattern < ActiveRecord::Migration
  def self.up
    working_day_id  = DayType.find_by_name!('Working day').id
    weekend_id      = DayType.find_by_name!('Weekend').id
    WeekPattern.create :name => 'Normal week',
                       :days => { '0' => weekend_id,
                                  '6' => weekend_id,
                                  '1' => working_day_id,
                                  '2' => working_day_id,
                                  '3' => working_day_id,
                                  '4' => working_day_id,
                                  '5' => working_day_id }
  end

  def self.down
    WeekPattern.where(:name => 'Normal week').destroy_all
  end
end