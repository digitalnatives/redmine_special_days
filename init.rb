Redmine::Plugin.register :redmine_special_days do
  name 'Redmine SpecialDays plugin'
  author 'LuckyThirteen'
  description 'This is a redmine plugin to handle special days like weekends, holidays etc.'
  version '0.0.1'
  #url ''

  menu :top_menu, 'redmine_special_days', { :controller => 'pocket_calendars', :action => 'index' },
     { :caption => 'redmine_special_days.menu_title'.to_sym,
       :if => Proc.new { User.current.admin } }

  settings :default => {'default_calendar_name' => 'Global'}, :partial => 'settings/redmine_special_days_settings'
end
