Trainz::Application.routes.draw do
  get "pages/home"

  root 'pages#home'

  get 'countries', to: 'trains#countries'
  get 'trains', to: 'trains#trains'
  get 'draw', to: 'trains#draw'
end
