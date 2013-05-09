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

  validates_presence_of :name, :days

  # TODO : smart validation on days (existing day_types, all days filled, etc.)

end
