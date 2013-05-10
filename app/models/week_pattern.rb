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

  DAYS = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"].freeze

  def self.for_select
    WeekPattern.all.map{ |wp| [wp.name, wp.id] }
  end

  def day_types
    dt_ids = days.values.uniq
    dts = DayType.find(dt_ids).inject({}){ |hsh, dt| hsh.tap{ |h| h[dt.id.to_s] = dt.to_hash} }
    days.map{ |wday, dt_id| { wday => dts[dt_id.to_s] } }.reduce(:merge)
  end

  DAYS.each_with_index do |day, index|
    define_method "#{day}" do
      self.days[index.to_s] rescue nil
    end
  end

  DAYS.each_with_index do |day, index|
    define_method "#{day}=" do |dt_id|
      self.days ||= {}
      self.days[index.to_s] = dt_id
    end
  end

  # TODO : smart validation on days (existing day_types, all days filled, etc.)

end
