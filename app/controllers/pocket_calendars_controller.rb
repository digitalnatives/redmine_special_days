class PocketCalendarsController < ApplicationController
  unloadable

  def index
    @pocket_calendars = PocketCalendar.all
  end

  def show
    @pocket_calendar = PocketCalendar.find(params[:id])
  end

end
