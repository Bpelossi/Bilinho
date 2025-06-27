class AddDefaultStatusToStudents < ActiveRecord::Migration[8.0]
  def change
    change_column_default :students, :status, from: nil, to: "enabled"
  end
end
