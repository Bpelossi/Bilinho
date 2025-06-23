class Student < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true,
                   uniqueness: { case_sensitive: true }
  validates :cpf, presence: true,
                  uniqueness: true,
                  format: { with: /\A\d+\z/, message: "CPF deve conter apenas números" },
                  length: { is: 11 }
  validates :gender, presence: true, inclusion: { in: %w[M F] }
  validates :payment_method, presence: true, inclusion: { in: %w[boleto cartão] }
end
