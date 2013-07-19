AppceptionTahoe::Application.routes.draw do
  resources :selftests


  resources :environments


  resources :timelines


  root :to => "home#index"

end
