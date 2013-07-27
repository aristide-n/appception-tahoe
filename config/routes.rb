AppceptionTahoe::Application.routes.draw do
  resources :selftests


  resources :environments


  resources :timelines

  match '/selftests/charts/:name' => 'selftests#opChart', :as => :operation
  match '/environments/charts/:env' => 'environments#deviceChart', :as => :chart
  root :to => "home#index"

end
