SGym::Application.routes.draw do

  resources :event_categories

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :news_stories do
    collection do
      get 'more'
    end
  end

  resources :events

  #placeholder for what will probably be d/users/new (new users though devise controller)
  get "tools/membership", :to => 'tools#membership', :as => 'membership'
  get "gym_sign_in", :to => 'tools#gym_sign_in'

  devise_for :users, :path_prefix => 'd'

  resources :users do
    resources :events, :only => [:index]
  end

  resources :users


  #root :to => 'news_stories#index'
  root :to => 'tools#home'
end
