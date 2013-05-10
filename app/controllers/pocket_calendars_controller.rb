class PocketCalendarsController < ApplicationController
  unloadable

  def index
    @pocket_calendars = PocketCalendar.all
  end

  def new
    @pocket_calendar = PocketCalendar.new
  end

  def create
    @pocket_calendar = PocketCalendar.new
    @pocket_calendar.attributes = params[:pocket_calendar]

    if @pocket_calendar.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to pocket_calendars_path
    else
      render :action => 'new'
    end
  end

  def edit
    @pocket_calendar = PocketCalendar.find(params[:id])
  end

  def update
    @pocket_calendar = PocketCalendar.find(params[:id])
    @pocket_calendar.attributes = params[:pocket_calendar]

    if @pocket_calendar.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to pocket_calendars_path
    else
      render :action => 'edit'
    end
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
