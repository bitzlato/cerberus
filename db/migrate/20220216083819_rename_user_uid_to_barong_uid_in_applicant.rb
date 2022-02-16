class RenameUserUidToBarongUidInApplicant < ActiveRecord::Migration[6.1]
  def change
    rename_column :applicants, :user_uid, :barong_uid
    rename_column :applicants, :applicant_id, :sumsub_applicant_id
    add_column :applicants, :bitzlato_id, :string
  end
end
