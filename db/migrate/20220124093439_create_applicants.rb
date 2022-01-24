class CreateApplicants < ActiveRecord::Migration[6.1]
  def change
    create_table :applicants do |t|
      t.string :applicant_id, null: false
      t.string :user_uid, null: false
      t.string :source_key
      t.datetime :start_date
      t.datetime :create_date
      t.string :review_status
      t.json :fixed_info, default: {}
      t.json :reject_labels, default: []
      t.string :moderation_comment
      t.string :client_comment
      t.string :review_answer
      t.string :review_reject_type
    end
  end
end
