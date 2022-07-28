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

ActiveRecord::Schema[7.0].define(version: 2022_07_22_223017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", primary_key: "account_number", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.decimal "balance", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["deleted_at"], name: "index_accounts_on_deleted_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_account_number", null: false
    t.string "type"
    t.decimal "amount"
    t.decimal "balance"
    t.datetime "created_at", null: false
  end

  add_foreign_key "transactions", "accounts", column: "account_account_number", primary_key: "account_number"
end
