Trainz::Application.routes.draw do
  get "pages/home"

  root 'pages#home'

  get 'draw', to: 'trains#draw'
  resources :trains, only: [:show, :index]
  resources :countries, only: :index
end
