# == Schema Information
#
# Table name: pocket_calendars
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  week_pattern_id :integer
#

class PocketCalendar < ActiveRecord::Base
  unloadable

  belongs_to :week_pattern

end
