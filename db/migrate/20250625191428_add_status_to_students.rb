class AddStatusToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :status, :string
  end
end
