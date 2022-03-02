class CreateVerifications < ActiveRecord::Migration[6.1]
  def change
    create_table :verifications do |t|
      t.integer :applicant_id
      t.string :country, limit: 2

      t.timestamps
    end
  end
end
