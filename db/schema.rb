# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_02_190601) do
  create_table "enrollments", force: :cascade do |t|
    t.decimal "full_price"
    t.integer "number_of_installments"
    t.integer "due_day"
    t.string "course_name"
    t.integer "institution_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "enabled"
    t.index ["institution_id"], name: "index_enrollments_on_institution_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "institution_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "enabled"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "invoice_price"
    t.date "invoice_due_date"
    t.integer "enrollment_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_invoices_on_enrollment_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.date "birthday"
    t.string "phone"
    t.string "gender"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "enabled"
  end

  add_foreign_key "enrollments", "institutions"
  add_foreign_key "enrollments", "students"
  add_foreign_key "invoices", "enrollments"
end
