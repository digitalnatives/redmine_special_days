class PocketCalendar < ActiveRecord::Base
  unloadable

  belongs_to :week_pattern

end
