class WeekPatternsController < ApplicationController
  unloadable

  def index
    @week_patterns = WeekPattern.all
  end

  def new
    @week_pattern = WeekPattern.new
  end

  def create
    @week_pattern = WeekPattern.new
    @week_pattern.attributes = params[:week_pattern]

    if @week_pattern.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to week_patterns_path
    else
      render :action => 'new'
    end
  end

  def edit
    @week_pattern = WeekPattern.find(params[:id])
  end

  def update
    @week_pattern = WeekPattern.find(params[:id])
    @week_pattern.attributes = params[:week_pattern]

    if @week_pattern.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to week_patterns_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @week_pattern = WeekPattern.find(params[:id])
    @week_pattern.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to week_patters_path
  end

end
