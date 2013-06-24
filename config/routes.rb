AppceptionTahoe::Application.routes.draw do
  resources :timelines


  root :to => "home#index"

end
