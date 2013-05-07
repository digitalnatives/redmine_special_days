class DayType < ActiveRecord::Base
  unloadable

  has_many :special_days

end
