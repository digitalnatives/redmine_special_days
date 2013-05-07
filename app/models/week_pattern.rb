# == Schema Information
#
# Table name: week_patterns
#
#  id   :integer          not null, primary key
#  name :string(255)
#  days :text
#

class WeekPattern < ActiveRecord::Base
  unloadable

  serialize :days

  has_many :pocket_calendars

end
