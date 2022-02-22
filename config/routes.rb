Rails.application.routes.draw do
  scope '/api/admin' do
    mount API::Admin::Mount => '/'
  end

  scope '/api/private' do
    mount API::Private::Mount => '/'
  end

  scope '/api/public' do
    mount API::Public::Mount => '/'
  end

  scope '/api/webhook' do
    mount API::Webhook => '/'
  end

  namespace :admin do
    resources :applicants, only: [:show, :index]
  end
end
