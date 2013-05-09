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
                 :show_today => true,
                 :nav_links => true,
                 :div_id => 'calendar-show',
                 :show_year => true }
    options = defaults.merge options

    first_day = Date.civil(year, month, 1)
    last_day  = Date.civil(year, month, -1)

    start_day = first_day.beginning_of_week # monday
    end_day   = last_day.end_of_week # sunday

    next_month = first_day.next_month
    prev_month = first_day.prev_month

    next_year  = first_day.next_year
    prev_year  = first_day.prev_year

    needs_nav = options[:nav_links] && options[:div_id]

    next_month_link = month_change_link('>>', calendar, next_month.year, next_month.month, options[:div_id], I18n.t('redmine_special_days.next_month'))
    prev_month_link = month_change_link('<<', calendar, prev_month.year, prev_month.month, options[:div_id], I18n.t('redmine_special_days.prev_month'))
    next_year_link  = month_change_link('>>>', calendar, next_year.year, next_year.month, options[:div_id], I18n.t('redmine_special_days.next_year'))
    prev_year_link  = month_change_link('<<<', calendar, prev_year.year, prev_year.month, options[:div_id], I18n.t('redmine_special_days.prev_year'))

    current_month_link  = month_change_link(I18n.t('redmine_special_days.current_month'), calendar, Date.today.year, Date.today.month, options[:div_id])

    title_colspan = options[:nav_links] ? 3 : 7
    title = options[:show_year] ? "#{year} #{I18n.t('date.month_names')[month]}" : I18n.t('date.month_names')[month]

    day_names  = I18n.t('date.day_names').rotate.zip(I18n.t('date.abbr_day_names').rotate) # monday first

    pretty_cal = ""

    pretty_cal << %(<div id="#{options[:div_id]}">) if options[:div_id]

    pretty_cal  << %(<table class="pretty_calendar" border="0" cellspacing="0" cellpadding="0">)
    pretty_cal    << %(<thead>)
    pretty_cal      << %(<tr>)
    pretty_cal        << %(<th colspan="1">#{prev_year_link}</th>) if needs_nav
    pretty_cal        << %(<th colspan="1">#{prev_month_link}</th>) if needs_nav
    pretty_cal        << %(<th colspan="#{title_colspan}" class="month-name">#{title}</th>)
    pretty_cal        << %(<th colspan="1">#{next_month_link}</th>) if needs_nav
    pretty_cal        << %(<th colspan="1">#{next_year_link}</th>) if needs_nav
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
            date = date.to_date
            pretty_cal << pretty_day(date, info, (date < first_day || date > last_day))
          end
        pretty_cal  << %(</tr>)
      end
    pretty_cal    << %(</tbody>)

    pretty_cal    << %(<thead><tr class="cal-footer"><th colspan="7">#{current_month_link}</th></tr></thead>) if needs_nav

    pretty_cal << %(</table>)

    pretty_cal << %(</div>) if options[:div_id]

    pretty_cal.html_safe
  end

  private

  def pretty_day(date, info, not_in_month=false)
    pretty_day = ""
    pretty_day << %(<td )
      pretty_day << %(class = ")
        pretty_day << %(day)
        pretty_day << %( not-in-month) if not_in_month
      pretty_day << %(")
      pretty_day << %( style="background-color: #{info[:color]}") unless not_in_month
      pretty_day << %( title="#{info[:description]}") if info[:description]
    pretty_day << %(>)
      pretty_day << date.day.to_s
    pretty_day << %(</td>)

    pretty_day.html_safe
  end

  def month_change_link(text, calendar, year, month, div_id, title = nil)
    link_to(text,
            Rails.application.routes.url_helpers.change_month_pocket_calendars_path(
              :calendar_id => calendar.id,
              :year => year,
              :month => month,
              :div_id => div_id),
            :remote => true,
            :method => :put,
            :title => title).html_safe
  end

end