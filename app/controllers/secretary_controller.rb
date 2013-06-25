class SecretaryController < ApplicationController
  unloadable

  accept_api_auth :day, :interval

  def day
    @date = Date.parse(params['date']) rescue nil

    if @date
      respond_to do |format|
        format.api { @day = Secretary.ask(:day, @date) }
      end
    else
      respond_to do |format|
        format.api  { head :unprocessable_entity }
      end
    end
  end

  def interval
    @from  = Date.parse(params['from']) rescue nil
    @to    = Date.parse(params['to']) rescue nil

    if @from && @to
      respond_to do |format|
        format.api { @interval = Secretary.ask(:interval, @from, @to) }
      end
    else
      respond_to do |format|
        format.api  { head :unprocessable_entity }
      end
    end
  end

end