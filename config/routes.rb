Rails.application.routes.draw do
  get 'applicant/index'
  get 'applicant/show'
  mount API => '/'

  namespace :admin do
    resources :applicant, only: [:show, :index]
  end
end
