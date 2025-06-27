class AddStatusToEnrollments < ActiveRecord::Migration[8.0]
  def change
    add_column :enrollments, :status, :string
  end
end
