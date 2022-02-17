class AddUidToApplicant < ActiveRecord::Migration[6.1]
  def change
    add_column :applicants, :uid, :string
  end
end
