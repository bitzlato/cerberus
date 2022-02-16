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

  context 'GET /api/kyc/status' do
    include_context 'authorized'
    describe 'ok' do
      before do
        @applicant = create(:applicant, :verified, user_uid: 1111)
      end
      it 'ok' do
        get '/api/kyc/status'
        expect(last_response.status).to eq(200)
        expect(json_response['status']).to eq(@applicant.status)
        expect(json_response['reject_labels']).to eq(@applicant.reject_labels)
        expect(json_response['client_comment']).to eq(@applicant.client_comment)
        expect(json_response['review_status']).to eq(@applicant.review_status)
        expect(json_response['start_date']).to eq(@applicant.start_date)
      end
    end
    describe 'init applicant' do
      it 'ok' do
        stub_create_applicant(applicant_id: 1111)
        get '/api/kyc/status'
        expect(last_response.status).to eq(200)
        applicant = Applicant.last
        expect(applicant.user_uid).to eq('1111')
        expect(json_response['status']).to eq('init')
      end
    end
  end

  context 'POST /api/kyc/verification_url' do
    include_context 'authorized'
    before do
      @params = {
        uid: 1111
      }

      @response = stub_websdk_link(applicant_id: @params[:uid])
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
        applicant_id: @applicant.user_uid
      }
      stub_reset(applicant_id: @applicant.applicant_id)
    end
    it 'ok' do
      post '/api/kyc/reset', @params
      expect(json_response['reset']).to eq(true)
    end
  end
end