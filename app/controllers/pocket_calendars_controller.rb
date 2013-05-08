class PocketCalendarsController < ApplicationController
  unloadable

  def index
    @pocket_calendars = PocketCalendar.all
  end

  def show
    @pocket_calendar = PocketCalendar.find(params[:id])
  end

  def change_month
    @calendar = PocketCalendar.find(params['calendar_id'].to_i)
    @year     = params[:year].to_i
    @month    = params[:month].to_i
    @div_id   = params[:div_id]

    respond_to do |format|
      format.js
    end
  end

end
