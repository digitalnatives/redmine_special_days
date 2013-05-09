class DayTypesController < ApplicationController
  unloadable

  def index
    @day_types = DayType.all
  end

  def new
    @day_type = DayType.new
  end

  def create
    @day_type = DayType.new
    @day_type.attributes = params[:day_type]

    if @day_type.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to day_types_path
    else
      render :action => 'new'
    end
  end

  def edit
    @day_type = DayType.find(params[:id])
  end

  def update
    @day_type = DayType.find(params[:id])
    @day_type.attributes = params[:day_type]

    if @day_type.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to day_types_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @day_type = DayType.find(params[:id])
    @day_type.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to day_types_path
  end

end
