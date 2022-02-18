module TestWebhook
  extend ActiveSupport::Concern
  included do
    def test_webhook(status)
      raise 'Cant use test webhook API in production' if Rails.env.production?

      review_result = verified_review if status == 'verified'
      review_result = rejected_review if status == 'rejected'
      review_result = final_review    if status == 'banned'
      Sumsub::Request.new.testing_on_test_environment(public_id, review_result)
    end


    private

    def rejected_review
      {
        "reviewAnswer": "RED",
        "moderationComment": "We do not accept screenshots. Please upload an original photo.",
        "clientComment": "Screenshots are not accepted.",
        "reviewRejectType": "RETRY",
        "rejectLabels": ["UNSATISFACTORY_PHOTOS","SCREENSHOTS"]
      }
    end

    def final_review
      {
        "reviewAnswer": "RED",
        "moderationComment": "We do not accept screenshots. Please upload an original photo.",
        "clientComment": "Screenshots are not accepted.",
        "reviewRejectType": "FINAL",
        "rejectLabels": ["UNSATISFACTORY_PHOTOS","SCREENSHOTS"]
      }
    end

    def verified_review
      {
        "reviewAnswer": "GREEN",
        "rejectLabels": []
      }
    end
  end
end