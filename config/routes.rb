Rails.application.routes.draw do
  
resources :books
  get 'books/index'

  
end
