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

ActiveRecord::Schema.define(version: 2021_01_24_032111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "categories_sub_categories", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "sub_category_id"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_clients_on_company_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "fantasy_name"
    t.string "document"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "segment_id"
    t.string "description"
    t.string "legal_name"
    t.string "phone"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.float "quantity"
    t.float "price"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "payer_document"
    t.decimal "value"
    t.integer "payment_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_payments_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.bigint "table_id"
    t.integer "status"
    t.float "total_price"
    t.string "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "ean", null: false
    t.text "description", null: false
    t.bigint "company_id", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "price"
    t.boolean "has_discount", default: false
    t.float "discount_price"
    t.integer "quantity", default: 0
    t.float "measure"
    t.integer "measure_unit", default: 0
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "products_sub_categories", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "sub_category_id"
  end

  create_table "sale_items", force: :cascade do |t|
    t.bigint "sale_id", null: false
    t.integer "product_id", null: false
    t.float "quantity", null: false
    t.integer "quantity_unit", default: 0, null: false
    t.float "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "logged_user", null: false
    t.integer "payment_method", null: false
    t.datetime "transaction_date", default: "2021-01-17 23:47:14", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_sales_on_company_id"
  end

  create_table "segments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name", null: false
    t.integer "places", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_tables_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "document", default: "", null: false
    t.integer "user_type", default: 0
    t.integer "gender", default: 0
    t.datetime "birthdate"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.integer "status", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "companies"
  add_foreign_key "clients", "users"
  add_foreign_key "companies", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_payments", "orders"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "companies"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "companies"
  add_foreign_key "tables", "companies"
end
