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

ActiveRecord::Schema.define(version: 2021_12_16_093540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

# Could not dump table "account" because of following StandardError
#   Unknown type 'kyc_status' for column 'kyc_status'

# Could not dump table "account_kyc_hist" because of following StandardError
#   Unknown type 'kyc_provider' for column 'provider'

  create_table "account_swap_log", primary_key: ["old_user_id", "new_user_id"], force: :cascade do |t|
    t.serial "id", null: false
    t.integer "old_user_id", null: false
    t.integer "new_user_id", null: false
    t.string "cause", limit: 512, null: false
    t.string "admin_code", null: false
    t.datetime "date", default: -> { "now()" }, null: false
  end

# Could not dump table "admin_user" because of following StandardError
#   Unknown type 'admin_role' for column 'role'

# Could not dump table "banned_user" because of following StandardError
#   Unknown type 'ban_action' for column 'action'

# Could not dump table "blockchain_tx" because of following StandardError
#   Unknown type 'blockchain_tx_status' for column 'status'

# Could not dump table "deposit" because of following StandardError
#   Unknown type 'deposit_status' for column 'status'

# Could not dump table "event" because of following StandardError
#   Unknown type 'event_type' for column 'event_type'

  create_table "flyway_schema_history", primary_key: "installed_rank", id: :integer, default: nil, force: :cascade do |t|
    t.string "version", limit: 50
    t.string "description", limit: 200, null: false
    t.string "type", limit: 20, null: false
    t.string "script", limit: 1000, null: false
    t.integer "checksum"
    t.string "installed_by", limit: 100, null: false
    t.datetime "installed_on", default: -> { "now()" }, null: false
    t.integer "execution_time", null: false
    t.boolean "success", null: false
    t.index ["success"], name: "flyway_schema_history_s_idx"
  end

  create_table "signed_operation_request", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211113", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211113_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211114", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211114_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211115", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211115_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211116", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211116_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211117", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211117_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211118", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211118_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211119", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211119_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211120", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211120_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211121", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211121_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211122", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211122_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211123", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211123_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211124", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211124_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211125", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211125_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211126", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211126_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211127", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211127_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211128", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211128_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211129", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211129_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211130", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211130_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211201", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211201_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211202", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211202_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211203", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211203_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211204", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211204_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211205", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211205_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211206", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211206_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211207", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211207_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211208", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211208_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211209", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211209_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211210", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211210_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211211", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211211_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211212", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211212_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211213", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211213_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211214", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211214_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211215", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211215_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

  create_table "signed_operation_request$20211216", primary_key: ["expires_date", "id"], force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "user_id", null: false
    t.string "command", limit: 63, null: false
    t.jsonb "params", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "confirmed_at"
    t.index ["id"], name: "signed_operation_request$20211216_id_idx", where: "(confirmed_at IS NULL)"
    t.check_constraint "(expires_date + expires_time) > confirmed_at", name: "signed_operation_request_check1"
    t.check_constraint "(expires_date + expires_time) > issued_at", name: "signed_operation_request_check"
  end

# Could not dump table "user_auth_pub_key" because of following StandardError
#   Unknown type 'oauth_aud' for column 'aud'

  create_table "user_token_mfa", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211210", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211211", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211212", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211213", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211214", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "user_token_mfa$20211215", primary_key: ["jwt_hash", "expires_date"], force: :cascade do |t|
    t.string "jwt_hash", limit: 64, null: false
    t.integer "user_id", null: false
    t.date "expires_date", null: false
    t.time "expires_time", null: false
    t.datetime "issued_at", null: false
    t.datetime "mfa_passed_at", default: -> { "now()" }, null: false
  end

  create_table "users", id: :integer, default: -> { "nextval('p2p.users_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "subject", limit: 510, null: false
    t.string "username", limit: 510, null: false
    t.boolean "email_verified", null: false
    t.boolean "chat_enabled", null: false
    t.boolean "email_auth_enabled", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.string "telegram_id", limit: 256
    t.string "auth0_id"
    t.integer "ref_parent_user_id", default: -> { "currval('p2p.users_id_seq'::regclass)" }
    t.integer "referrer"
    t.string "country"
    t.text "real_email"
    t.boolean "2fa_enabled", default: false, null: false
    t.boolean "authority_can_make_deal", default: true, null: false
    t.boolean "authority_can_make_order", default: true, null: false
    t.boolean "authority_can_make_voucher", default: true, null: false
    t.boolean "authority_can_make_withdrawal", default: true, null: false
    t.boolean "authority_is_admin", default: false, null: false
    t.datetime "deleted_at"
  end

# Could not dump table "wallet_address_hist" because of following StandardError
#   Unknown type 'wallet_address_change_reason' for column 'reason'

# Could not dump table "withdrawal" because of following StandardError
#   Unknown type 'withdrawal_status' for column 'status'

  create_table "withdrawal_log", id: :integer, default: -> { "nextval('payment_logs_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "withdrawal_id", null: false
    t.text "log", null: false
    t.datetime "created_at", precision: 0, default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  add_foreign_key "account_swap_log", "admin_user", column: "admin_code", primary_key: "code", name: "account_swap_log_admin_code_fkey"
  add_foreign_key "banned_user", "admin_user", column: "admin_code", primary_key: "code", name: "banned_user_admin_code_fkey"
  add_foreign_key "deposit", "blockchain_tx", name: "deposit_blockchain_tx_id_fkey"
  add_foreign_key "users", "users", column: "ref_parent_user_id", name: "users_ref_parent_user_id_fkey"
  add_foreign_key "wallet_address_hist", "admin_user", column: "admin_code", primary_key: "code", name: "wallet_address_hist_admin_code_fkey"
  add_foreign_key "withdrawal", "blockchain_tx", name: "withdrawal_blockchain_tx_id_fkey"
end
