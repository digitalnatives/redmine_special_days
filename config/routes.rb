# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :pocket_calendars, :only => [:index, :show] do
  collection do
    put 'change_month'
  end
end