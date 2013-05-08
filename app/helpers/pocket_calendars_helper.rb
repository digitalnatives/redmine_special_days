require 'date'

module PocketCalendarsHelper
  def special_days_overview(calendar)
    overview = ""
    overview      << %(<ul>)
      calendar.special_days_grouped_by_year.each do |year, days|
        overview    << %(<li>#{year}</li>)
        overview      << %(<ul>)
          days.each do |day|
            overview    << %(<li>#{I18n.l day.date} : #{day.description}</li>)
          end
        overview      << %(</ul>)
      end
    overview      << %(</ul>)

    overview.html_safe
  end

  def pretty_calendar(calendar, year, month, options={})
    defaults = { :first_day_of_week => 1,
                 :edit => false,
                 :show_today => true }
    options = defaults.merge options

    first_day = Date.civil(year, month, 1)
    last_day  = Date.civil(year, month, -1)

    start_day = first_day.beginning_of_week # monday
    end_day   = last_day.end_of_week # sunday

    day_names  = I18n.t('date.day_names').rotate.zip(I18n.t('date.abbr_day_names').rotate) # monday first

    pretty_cal = ""

    pretty_cal  << %(<table class="pretty_calendar" border="0" cellspacing="0" cellpadding="0">)

    pretty_cal    << %(<thead>)
    pretty_cal      << %(<tr>)
    pretty_cal        << %(<th colspan="7" class="month-name">#{I18n.t('date.month_names')[month]}</th>)
    pretty_cal      << %(<tr>)
    pretty_cal      << %(<tr class="day-names">)
    day_names.each do |dname, abbr_dname|
      pretty_cal      << "<th scope='col'><abbr title='#{dname}'>#{abbr_dname}</abbr></th>"
    end
    pretty_cal      << %(</tr>)
    pretty_cal    << %(</thead>)

    pretty_cal    << %(<tbody>)
      calendar.interval(start_day, end_day).to_a.each_slice(7) do |week|
        pretty_cal  << %(<tr>)
          week.each do |date, info|
            klass = "day"
            color = info[:color]
            if (date.to_date < first_day || date.to_date > last_day)
              klass << " not-in-month"
              color = nil
            end
            pretty_cal  << %(<td class="#{klass}" style="background-color: #{color}" title="#{info[:description]}">#{date.to_date.day}</td>)
          end
        pretty_cal  << %(</tr>)
      end
    pretty_cal    << %(</tbody>)

    pretty_cal.html_safe
  end
end
