class WeekPattern < ActiveRecord::Base
  unloadable

  serialize :days

  has_many :pocket_calendars

end
