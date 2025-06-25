class Invoice < ApplicationRecord
  belongs_to :enrollment

  validates :invoice_price, presence: true
  validates :invoice_due_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[open late paid disabled] }
end
