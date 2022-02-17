class CreateApplicants < ActiveRecord::Migration[6.1]
  def change
    create_table :applicants do |t|
      t.string :uid
      t.string :sumsub_applicant_id
      t.string :inspection_id
      t.string :barong_uid
      t.string :bitzlati_id
      t.string :source_key
      t.datetime :start_date
      t.datetime :create_date
      t.integer :status
      t.string :review_status
      t.string :moderation_comment
      t.string :client_comment
      t.string :review_answer
      t.string :review_reject_type
      t.string :webhook_type

      t.json :raw_request, default: {}
      t.json :fixed_info, default: {}
      t.json :reject_labels, default: []
    end
  end
end
