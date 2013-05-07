# == Schema Information
#
# Table name: day_types
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  duration :integer          default(0)
#  color    :string(255)
#

require File.expand_path('../../test_helper', __FILE__)

class DayTypeTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
