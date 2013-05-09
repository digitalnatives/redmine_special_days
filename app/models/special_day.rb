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

  validates_presence_of   :pocket_calendar_id, :day_type_id, :date

  # TODO : is this a good idea?
  # validates_uniqueness_of :date, :scope => :pocket_calendar_id

  def to_hash
    day_type.to_hash.merge :description => description
  end

end
