class AddStatusToInstitutions < ActiveRecord::Migration[8.0]
  def change
    add_column :institutions, :status, :string
  end
end
