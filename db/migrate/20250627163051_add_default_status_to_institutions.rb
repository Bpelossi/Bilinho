class AddDefaultStatusToInstitutions < ActiveRecord::Migration[8.0]
  def change
    change_column_default :institutions, :status, from: nil, to: "enabled"
  end
end
