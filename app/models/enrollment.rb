class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student
  has_many :invoices, dependent: :destroy

  validates :full_price,  presence: true,
                          numericality: { greater_than: 0 }
  validates :number_of_installments, presence: true,
                                  numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :due_date, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true
  validates :student, presence: true
  validates :institution, presence: true
end
