Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get :laggers, to: 'beers#laggers'
  get :ipas, to: 'beers#ipas'
end
