class Institution < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :cnpj, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "CNPJ deve conter apenas números" }
  validates :institution_type, presence: true, inclusion: { in: %w[escola creche] }
end
