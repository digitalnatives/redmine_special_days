# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :pocket_calendars do
  collection do
    put 'change_month'
  end
end

resources :day_types

resources :week_patterns