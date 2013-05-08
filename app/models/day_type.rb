# == Schema Information
#
# Table name: day_types
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  duration :integer          default(0)
#  color    :string(255)
#

class DayType < ActiveRecord::Base
  unloadable

  has_many :special_days

  def to_hash
    { :name => name, :duration => duration, :color => color }
  end

end
