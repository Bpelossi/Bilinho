class Student < ApplicationRecord
  has_many :enrollments

  enum gender: { male: "M", female: "F" }, _suffix: true
  enum payment_method: { boleto: "Boleto", cartao: "Cartão" }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: true }
  validates :cpf, presence: true,
                  uniqueness: true,
                  format: { with: /\A\d+\z/, message: "CPF deve conter apenas números" },
                  length: { is: 11 }
  validates :gender, presence: true
  validates :payment_method, presence: true
end
