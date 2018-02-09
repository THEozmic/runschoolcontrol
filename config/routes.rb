Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :schools

  post 'auth/register', to: 'schools#register'
  post 'auth/login', to: 'schools#login'
  get 'test', to: 'schools#test'

end
