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
  validates :status, presence: true, inclusion: { in: %w[enabled disabled] }
  validate :immutable_fields_after_creation, on: :update

  def immutable_fields_after_creation
    if cpf_changed?
      errors.add(:cpf, "não pode ser alterado após a criação")
    end
  end
end
