require 'rails_helper'

describe 'API::Kyc', type: :api do
  include Rack::Test::Methods

  def app
    API::Kyc
  end

  context 'GET /api/kyc/verification_url' do
    before do
      @params = {
        user_id: rand(999999)
      }
      @response = stub_websdk_link(user_id: @params[:user_id])
    end
    it 'ok' do
      get '/api/kyc/verification_url', @params
      expect(last_response.status).to eq(200)
      expect(json_response['url']).to eq(@response[:url])
    end
  end

  context 'POST /api/kyc/reset' do
  end
end