require 'rails_helper'

describe 'API::Kyc', type: :api do
  # include Rack::Test::Methods


  shared_context 'authorized' do
    before do
      API::Private::Mount.helpers do
        def current_user_uid
          1111
        end
      end
    end
  end

  def app
    API::Private::KYC
  end

  context 'GET /api/private/kyc/verification' do
    include_context 'authorized'
    describe 'ok' do
      before do
        stub_create_applicant(public_id: 1111)
      end
      it 'ok' do
        get '/kyc/verification'
        expect(last_response.status).to eq(200)
        applicant = Applicant.last
        expect(applicant.barong_uid).to eq('1111')
        expect(applicant.sumsub_applicant_id).to eq('61fcc341e552bf0001086cf8')
      end
    end
  end

  context 'POST /api/private/kyc/verification' do
    include_context 'authorized'
    before do
      @params = {
        uid: 1111
      }
      stub_create_applicant(public_id: @params[:uid])
      @response = stub_websdk_link
    end
    it 'ok' do
      post '/kyc/verification'
      expect(last_response.status).to eq(201)
      expect(json_response['url']).to eq(@response[:url])
    end
  end
end