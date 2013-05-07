# == Schema Information
#
# Table name: special_days
#
#  id          :integer          not null, primary key
#  calendar_id :integer
#  day_type_id :integer
#  date        :date
#  description :string(255)
#

require File.expand_path('../../test_helper', __FILE__)

class SpecialDayTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
