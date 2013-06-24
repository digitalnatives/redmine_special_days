module WeekPatternsHelper

  def human_day_types(week_pattern)
    day_names  = I18n.t('date.day_names').rotate

    dt_html = []

    week_pattern.day_types.sort.map do |wday, info|
      dt_html << "#{day_names[wday.to_i]} : #{info[:name]}"
    end

    dt_html.join("<br/>").html_safe
  end

end
