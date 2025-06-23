class Institution < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :cnpj, presence: true,
                   uniqueness: { message: "Deve ser único para cada instituição" },
                   format: { with: /\A\d+\z/, message: "CNPJ deve conter apenas números" },
                   length: { is: 14 }
  validates :institution_type, presence: true, inclusion: { in: %w[universidade escola creche] }
end
