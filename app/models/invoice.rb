class Invoice < ApplicationRecord
  belongs_to :enrollment

  validates :invoice_price, presence: true
  validates :invoice_due_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[open late paid disabled] }

  validate :immutable_fields_after_creation, on: :update

  def immutable_fields_after_creation
    if invoice_price_changed?
      errors.add(:invoice_price, "não pode ser alterado após a criação")
    end
    if invoice_due_date_changed?
      errors.add(:invoice_due_date, "não pode ser alterado após a criação")
    end
    if enrollment_id_changed?
      errors.add(:enrollment_id_changed, "não pode ser alterado após a criação")
    end
  end
end
