require 'rails_helper'

describe 'API::Webhook', type: :api do
  include Rack::Test::Methods

  def app
    API::Webhook
  end

  describe 'POST /api/webhook/sumsub' do
    before do
      @params = {"applicantId"=>"60a28411460647000a941c85", "inspectionId"=>"60a28411460647000a941c86", "applicantType"=>"individual", "correlationId"=>"req-60aa035f-0901-4b57-bb84-4700c070bb5c", "externalUserId"=>"copy-5f0c29b2-7292-4f73-8bc6-e5cc862954f6", "type"=>"applicantReviewed", "reviewResult"=>{"moderationComment"=>"We cannot verify your profile. Please, contact support.\n\n", "clientComment"=>"Common comments:\n\nSuspected fake account.\n-----------------------------------\n\nComments for the user:\n\nID_CARD - FRONT_SIDE (DEU) - id: 1304451637\nPhotos processed with image editors are not accepted.\n\n\n\nID_CARD - BACK_SIDE (DEU) - id: 1278657187\nPhotos processed with image editors are not accepted.\n\n\n\nSELFIE (DEU) - id: 1220323185\nPhotos processed with image editors are not accepted.\n\n", "reviewAnswer"=>"RED", "rejectLabels"=>["FORGERY", "UNSATISFACTORY_PHOTOS", "GRAPHIC_EDITOR", "BLACKLIST"], "reviewRejectType"=>"FINAL"}, "reviewStatus"=>"completed", "createdAt"=>"2022-01-26 12:22:25+0000", "clientId"=>"bitzlato"}
    end
    it 'ok' do
      post '/api/webhook/sumsub', @params
      expect(last_response.status).to eq(201)
      expect(Applicant.count).to eq(1)
    end
  end
end