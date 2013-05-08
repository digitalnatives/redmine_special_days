# == Schema Information
#
# Table name: special_days
#
#  id          :integer          not null, primary key
#  pocket_calendar_id :integer
#  day_type_id :integer
#  date        :date
#  description :string(255)
#

class SpecialDay < ActiveRecord::Base
  unloadable

  belongs_to :pocket_calendar
  belongs_to :day_type

end
