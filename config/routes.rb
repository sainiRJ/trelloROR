Rails.application.routes.draw do
  get '/employee/register', to: 'employees#new'
  post '/employee/register', to: 'employees#create'
  get '/employee/verify', to: 'employees#verify'
  post '/employee/verify', to: 'employees#postVerify'
  get '/employee/login', to: 'employees#login_form'
  post '/employee/login', to: 'employees#login'

  resources :managers, only: [:index, :show]

  root 'managers#index'
  get 'manager/index', to: 'managers#index'
  get '/manager/register', to: 'managers#new'
  post '/manager/register', to: 'managers#create'
  get '/manager/verify', to: 'managers#verify'
  post '/manager/verify', to: 'managers#postVerify'
  get '/manager/login', to: 'managers#login_form'
  post '/manager/login', to: 'managers#login'

  post '/manager/all', to: 'managers#manager'
  get '/manager/all', to: 'managers#manager'

  get '/task', to: 'tasks#new'
  post '/task', to: 'tasks#create'



  
end
