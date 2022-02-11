
class BitzlatoInvoice < BitzlatoRecord
  self.table_name = :invoice
  self.inheritance_column = nil

  def available?
    active? && deleted_at.nil? && completed_at.nil? && (expiry_at.present? && expiry_at < DateTime.current)
  end

  def referrer_id
    merchant.user.id
  end
end