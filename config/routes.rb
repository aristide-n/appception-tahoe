AppceptionTahoe::Application.routes.draw do
  resources :selftests


  resources :environments


  resources :timelines

  match '/selftests/charts/:name' => 'selftests#opChart', :as => :operation
  match '/environments/charts/:env' => 'environments#deviceChart', :as => :chart
  root :to => "home#index"
  match '/timelines/devices/all/:device_name' => 'timelines#show_device', :as => :device
  match '/timelines/devices/all' => 'timelines#index_devices'
  match '/timelines/tests/all/:test_name' => 'timelines#show_test', :as => :test
  match '/timelines/tests/all' => 'timelines#index_tests'

end
