class Institution < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :cnpj, presence: true,
                   uniqueness: { message: "Deve ser único para cada instituição" },
                   format: { with: /\A\d+\z/, message: "CNPJ deve conter apenas números" },
                   length: { is: 14 }
  validates :institution_type, presence: true, inclusion: { in: %w[universidade escola creche] }
  validates :status, presence: true, inclusion: { in: %w[enabled disabled] }
  validate :immutable_fields_after_creation, on: :update

  def immutable_fields_after_creation
    if cnpj_changed?
      errors.add(:cpf, "não pode ser alterado após a criação")
    end
  end
end
