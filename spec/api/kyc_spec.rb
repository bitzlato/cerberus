require 'rails_helper'

describe 'API::Kyc', type: :api do
  include Rack::Test::Methods


  shared_context 'authorized' do
    before do
      API.helpers do
        def current_user_uid
          1111
        end
      end
    end
  end

  def app
    API::Kyc
  end

  context 'GET /api/kyc/verification_url' do
    include_context 'authorized'
    before do
      @params = {
        uid: 1111
      }

      @response = stub_websdk_link(user_id: @params[:uid])
    end
    it 'ok' do
      post '/api/kyc/verification_url'
      expect(last_response.status).to eq(201)
      expect(json_response['url']).to eq(@response[:url])
    end
  end

  context 'POST /api/kyc/reset' do
    include_context 'authorized'

    before do
      @applicant = create(:applicant, :verified, user_uid: 1111)
      @params = {
        user_id: @applicant.user_uid
      }
      stub_reset(applicant_id: @applicant.applicant_id)
    end
    it 'ok' do
      post '/api/kyc/reset', @params
      expect(json_response['reset']).to eq(true)
    end
  end
end