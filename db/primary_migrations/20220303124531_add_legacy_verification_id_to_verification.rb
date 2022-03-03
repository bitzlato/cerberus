class AddLegacyVerificationIdToVerification < ActiveRecord::Migration[6.1]
  def change
    add_column :verifications, :legacy_verification_id, :string
  end
end
