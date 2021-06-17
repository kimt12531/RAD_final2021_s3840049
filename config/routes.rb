Rails.application.routes.draw do
  get 'answers/new'
  get 'answers/create'
  resources :questions
  root 'static_pages#home'

  post '/counter', to: 'static_pages#counter'

  get '/results', to: 'static_pages#result'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
