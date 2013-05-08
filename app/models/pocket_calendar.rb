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
  has_many :special_days

  def day_types
    @day_types ||= compute_day_types
  end

  def mundane_day(day)
    day_types[day.wday.to_s]
  end

  def day(date)
    spec = special_days.find_by_date(date)
    spec ? spec.to_hash : mundane_day(day)
  end

  def interval(from, to)
    spec = special_days.find_all_by_date(from..to).inject({}) do |hsh, sd|
      hsh.tap{ |h| h[sd.date.to_s] = sd.to_hash }
    end

    (from..to).inject({}) do |hsh, date|
      hsh.tap{ |h| h[date.to_s] = spec[date.to_s] || mundane_day(date) }
    end
  end

  def special_days_grouped_by_year
    special_days.order("date DESC").group_by{ |sd| sd.date.year.to_s }
  end

  private
  def compute_day_types
    dt_ids = week_pattern.days.values.uniq
    dts = DayType.find(dt_ids).inject({}){ |hsh, dt| hsh.tap{ |h| h[dt.id.to_s] = dt.to_hash} }
    week_pattern.days.map{ |wday, dt_id| { wday => dts[dt_id.to_s] } }.reduce(:merge)
  end

end
