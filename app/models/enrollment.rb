class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student
  has_many :invoices, dependent: :destroy

  validates :full_price,  presence: true,
                          numericality: { greater_than: 0 }
  validates :number_of_installments, presence: true,
                                  numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :due_day, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true
  validates :student, presence: true
  validates :institution, presence: true

  after_create :generate_invoices

  private

  def generate_invoices
    self.number_of_installments.times do |i|
      invoices.create!(
        invoice_price: calculate_installment_price,
        invoice_due_date: calculate_due_date(i),
        status: "open"
      )
    end
  end

  def calculate_installment_price
    return 0 if self.number_of_installments <= 0
    (self.full_price/self.number_of_installments).round(2)
  end

  def calculate_due_date(month_offset)
    if self.due_day >= Date.today.day
      today = Date.today >> month_offset
      due_date = verify_date(today)
    else
      today = Date.today >> month_offset+1
      due_date = verify_date(today)
    end
    due_date
  end

  def verify_date(day)
    if Date.valid_date?(day.year, day.month, self.due_day)
      due_date = Date.new(day.year, day.month, self.due_day)
    else
      due_date = Date.new(day.year, day.month, -1)
    end
    due_date
  end
end
