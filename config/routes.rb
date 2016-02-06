Trainz::Application.routes.draw do
  get "pages/home"

  root 'pages#home'

  get 'companies', to: 'trains#companies'
  get 'trains', to: 'trains#index'
end
