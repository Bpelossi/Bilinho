class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.decimal :full_price
      t.integer :number_of_installments
      t.integer :due_day
      t.string :course_name
      t.references :institution, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
