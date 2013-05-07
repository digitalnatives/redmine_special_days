# == Schema Information
#
# Table name: pocket_calendars
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  week_pattern_id :integer
#

require File.expand_path('../../test_helper', __FILE__)

class PocketCalendarTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
