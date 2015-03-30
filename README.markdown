# Deprecation notice

This repository is not maintained.

# Redmine SpecialDays Plugin

Redmine SpecialDays is a plugin to help you track special days like weekends, holidays, etc..
It's similar to the Redmine Multi Calendar plugin, but works works with the latest (2.x) version of Redmine.

With the plugin you can:

*   see a "Special days" main menu item in the header with admin
*   use a predefined set of day types, week pattern and a default calendar
*   define day types
*   define week patterns
*   create calendars
*   create special days in the calendars
*   see a yearly overview per calendar
*   request day/interval information trough a lib class and an api called Secretary which uses the default calendar

# Get the plugin

Get the latest source from [GitHub](https://github.com/LuckyThirteen/redmine_special_days.git).

# Compatibility

This plugin is compatible with Redmine 2.x (tested with 2.3).

If you're using Redmine 1.4, check out the [Redmine Multi Calendar plugin](https://github.com/ksfltd/redmine_multi_calendar).

# Installation

Follow the Redmine [plugin installation steps](http://www.redmine.org/wiki/redmine/Plugins).

*   Make sure the plugin was copied to plugins/redmine_special_days (git clone https://github.com/LuckyThirteen/redmine_special_days.git)
*   Run the plugin migrations (rake redmine:plugins:migrate)
*   Restart your Redmine web servers (e.g. mongrel, thin, mod_rails)
*   Click the "Special days" link in the top (main) menu with an admin user
*   You can set the default calendar name under setting->plugins
