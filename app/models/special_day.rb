class SpecialDay < ActiveRecord::Base
  unloadable

  belongs_to :pocket_calendar
  belongs_to :day_type

end
