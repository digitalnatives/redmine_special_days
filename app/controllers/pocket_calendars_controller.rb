class PocketCalendarsController < ApplicationController
  unloadable

  def index
    @pocket_calendars = PocketCalendar.all
  end

  def show
  end
end
