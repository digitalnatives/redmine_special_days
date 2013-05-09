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

    needs_nav = options[:nav_links] && options[:div_id]

    pretty_cal = ""

    pretty_cal << %(<div id="#{options[:div_id]}">) if options[:div_id]
    pretty_cal  << %(<table class="pretty_calendar" border="0" cellspacing="0" cellpadding="0">)
    pretty_cal    << %(<thead>)
    pretty_cal      << calendar_title_row(calendar, first_day,
                                          needs_nav, options[:show_year], options[:div_id])
    pretty_cal      << calendar_day_names
    pretty_cal    << %(</thead>)
    pretty_cal    << calendar_body(calendar, first_day, last_day)
    pretty_cal    << calendar_footer(calendar, options[:div_id]) if needs_nav
    pretty_cal << %(</table>)
    pretty_cal << %(</div>) if options[:div_id]

    pretty_cal.html_safe
  end

  private

  def calendar_body(calendar, first_day, last_day)
    start_day = first_day.beginning_of_week # monday
    end_day   = last_day.end_of_week # sunday

    cal_body     = %(<tbody>)
      calendar.interval(start_day, end_day).to_a.each_slice(7) do |week|
        cal_body  << %(<tr>)
          week.each do |date, info|
            date = date.to_date
            cal_body << calendar_day(date, info, (date < first_day || date > last_day))
          end
        cal_body  << %(</tr>)
      end
    cal_body    << %(</tbody>)

    cal_body.html_safe
  end

  def calendar_day_names
    day_names  = I18n.t('date.day_names').rotate.zip(I18n.t('date.abbr_day_names').rotate) # monday first

    dnames    = %(<tr class="day-names">)
      day_names.each do |dname, abbr_dname|
        dnames << "<th scope='col'><abbr title='#{dname}'>#{abbr_dname}</abbr></th>"
      end
    dnames   << %(</tr>)

    dnames.html_safe
  end

  def calendar_title_row(calendar, first_day, needs_nav, show_year, div_id)
    title_colspan = needs_nav ? 3 : 7
    title = if show_year
              "#{first_day.year} #{I18n.t('date.month_names')[first_day.month]}"
            else
              I18n.t('date.month_names')[month]
            end

    next_month = first_day.next_month
    prev_month = first_day.prev_month
    next_year  = first_day.next_year
    prev_year  = first_day.prev_year

    next_month_link = month_change_link('>>', calendar, next_month.year, next_month.month,
                                        div_id, I18n.t('redmine_special_days.next_month'))
    prev_month_link = month_change_link('<<', calendar, prev_month.year, prev_month.month,
                                        div_id, I18n.t('redmine_special_days.prev_month'))
    next_year_link  = month_change_link('>>>', calendar, next_year.year, next_year.month,
                                        div_id, I18n.t('redmine_special_days.next_year'))
    prev_year_link  = month_change_link('<<<', calendar, prev_year.year, prev_year.month,
                                        div_id, I18n.t('redmine_special_days.prev_year'))

    title_row  = %(<tr>)
    title_row   << %(<th colspan="1">#{prev_year_link}</th>) if needs_nav
    title_row   << %(<th colspan="1">#{prev_month_link}</th>) if needs_nav
    title_row   << %(<th colspan="#{title_colspan}" class="month-name">#{title}</th>)
    title_row   << %(<th colspan="1">#{next_month_link}</th>) if needs_nav
    title_row   << %(<th colspan="1">#{next_year_link}</th>) if needs_nav
    title_row << %(<tr>)

    title_row.html_safe
  end

  def calendar_footer(calendar, div_id)
    current_month_link  = month_change_link(I18n.t('redmine_special_days.current_month'),
                                            calendar,
                                            Date.today.year, Date.today.month,
                                            div_id)

    %(<thead><tr class="cal-footer"><th colspan="7">#{current_month_link}</th></tr></thead>).html_safe
  end

  def calendar_day(date, info, not_in_month=false)
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