Rails.application.routes.draw do
  scope '/api/admin' do
    mount API::Admin::Mount => '/'
  end

  scope '/api/cerberus/private' do
    mount API::Private::Mount => '/'
  end

  scope '/api/cerberus/public' do
    mount API::Public::Mount => '/'
  end

  scope '/api/cerberus/webhook' do
    mount API::Webhook => '/'
  end

  namespace :admin do
    resources :applicants, only: [:show, :index]
  end
end
