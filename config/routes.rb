Rails.application.routes.draw do
  mount API => '/'

  namespace :admin do
    resources :applicants, only: [:show, :index]
  end
end
