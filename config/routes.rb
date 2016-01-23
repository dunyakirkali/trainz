Trainz::Application.routes.draw do
  get "pages/home"

  root 'pages#home'

  get 'trains', to: 'trains#index', as: :trains
end
