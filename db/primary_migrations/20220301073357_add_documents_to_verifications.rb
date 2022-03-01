class AddDocumentsToVerifications < ActiveRecord::Migration[6.1]
  def change
    add_column :verifications, :documents, :json
  end
end
