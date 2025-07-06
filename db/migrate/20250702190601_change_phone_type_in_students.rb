class ChangePhoneTypeInStudents < ActiveRecord::Migration[8.0]
  def up
    change_column :students, :phone, :string
  end

  def down
    change_column :students, :phone, :integer
  end
end
