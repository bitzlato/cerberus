class CreateApplicants < ActiveRecord::Migration[6.1]
  def change
    create_table :applicants do |t|
      t.integer :status
      t.string :barong_uid
      t.string :bitzlato_id
      t.string :sumsub_applicant_id
      t.json :sumsub_request, default: {}
    end
  end
end
