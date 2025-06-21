class Invoice < ApplicationRecord
  belongs_to :enrollment

  validates :invoice_price, presence: true
  validates :invoice_due_date, presence: true
  enum status: {
    open: "Open",
    late: "Late",
    paid: "Paid"
  }
  validates :status, presence: true
  after_initialize { self.status ||= Invoice.statuses[:open] }
end
