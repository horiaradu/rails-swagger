Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: { sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :beers

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
