class Secretary

  class MissingCalendarException < StandardError; end

  attr_reader :calendar

  # Usage: (with default calendar_name set)

  # Secretary.ask :today
  # Secretary.ask :tomorrow
  # Secretary.ask :yesterday
  # Secretary.ask :this_week
  # Secretary.ask :this_month
  # Secretary.ask :this_year

  # Secretary.ask :day, date
  # Secretary.ask :interval, from, to, options
  def self.ask(question, *args)
    new.send(question, *args)
  end

  def initialize(calendar_name = Setting.plugin_redmine_special_days[:default_calendar_name])
    raise MissingCalendarException unless @calendar = PocketCalendar.find_by_name(calendar_name)
  end

  # Usage:

  # Secretary.new(calendar_name).day('2013-01-15'.to_date)
  # => {:name=>"Holiday", :duration=>0.0, :color=>"#FDC28C", :description=>"pihi"}
  def day(date)
    calendar.day(date)
  end

  # Usage:

  # Secretary.new(calendar_name).interval('2013-01-10'.to_date, '2013-01-17'.to_date)
  # => {"2013-01-10"=>{:name=>"Working day", :duration=>8.0, :color=>"#FDC68C"},
  #     "2013-01-11"=>{:name=>"Working day", :duration=>8.0, :color=>"#FDC68C"},
  #     "2013-01-12"=>{:name=>"Weekend", :duration=>0.0, :color=>"#FDC68A"},
  #     "2013-01-13"=>{:name=>"Weekend", :duration=>0.0, :color=>"#FDC68A"},
  #     "2013-01-14"=>{:name=>"Working day", :duration=>8.0, :color=>"#FDC68C"},
  #     "2013-01-15"=>{:name=>"Holiday", :duration=>0.0, :color=>"#FDC28C", :description=>"pihi"},
  #     "2013-01-16"=>{:name=>"Working day", :duration=>8.0, :color=>"#FDC68C"},
  #     "2013-01-17"=>{:name=>"Working day", :duration=>8.0, :color=>"#FDC68C"}}

  # Secretary.new(calendar_name).interval('2013-01-10'.to_date, '2013-01-17'.to_date, :day_type =>'Working day').keys
  # => ["2013-01-10", "2013-01-11", "2013-01-14", "2013-01-16", "2013-01-17"]

  def interval(from, to, options={})
    all_days = calendar.interval(from, to)
    return all_days.reject{ |k,v| v[:name] != options[:day_type] } if options[:day_type]

    all_days
  end

  ['today', 'tomorrow', 'yesterday'].each do |date_name|
    define_method(date_name) { day(Date.send(date_name)) }
  end

  ['this_week', 'this_month', 'this_year'].each do |interval_name|
    define_method interval_name do |*args|
      options ||= args.first || {}
      date_fun  = interval_name.split('_').last
      from      = Date.today.send("beginning_of_#{date_fun}")
      to        = Date.today.send("end_of_#{date_fun}")
      interval(from, to, options)
    end
  end

end