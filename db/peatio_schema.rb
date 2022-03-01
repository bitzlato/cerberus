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

ActiveRecord::Schema.define(version: 2022_02_15_141005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", primary_key: ["currency_id", "member_id"], force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "currency_id", limit: 20, null: false
    t.decimal "balance", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "locked", precision: 36, scale: 18, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id", "member_id"], name: "index_accounts_on_currency_id_and_member_id", unique: true
    t.index ["member_id"], name: "index_accounts_on_member_id"
  end

  create_table "adjustments", force: :cascade do |t|
    t.string "reason", null: false
    t.text "description", null: false
    t.bigint "creator_id", null: false
    t.bigint "validator_id"
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.integer "asset_account_code", limit: 2, null: false
    t.string "receiving_account_number", limit: 64, null: false
    t.string "currency_id", null: false
    t.integer "category", limit: 2, null: false
    t.integer "state", limit: 2, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["currency_id", "state"], name: "index_adjustments_on_currency_id_and_state"
    t.index ["currency_id"], name: "index_adjustments_on_currency_id"
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "name", limit: 64, null: false
    t.string "description", default: ""
    t.integer "pin", null: false
    t.integer "state", limit: 2, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sent_at"
    t.string "data_encrypted", limit: 1024
    t.bigint "blockchain_currency_id", null: false
    t.index ["member_id"], name: "index_beneficiaries_on_member_id"
  end

  create_table "block_numbers", force: :cascade do |t|
    t.bigint "blockchain_id", null: false
    t.integer "transactions_processed_count", default: 0, null: false
    t.bigint "number", null: false
    t.string "status", null: false
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockchain_id", "number"], name: "index_block_numbers_on_blockchain_id_and_number", unique: true
    t.index ["blockchain_id"], name: "index_block_numbers_on_blockchain_id"
  end

  create_table "blockchain_addresses", force: :cascade do |t|
    t.string "address_type", null: false
    t.citext "address", null: false
    t.string "private_key_hex_encrypted", comment: "Is must be NOT NULL but vault-rails does not support it"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address", "address_type"], name: "index_blockchain_addresses_on_address_and_address_type", unique: true
  end

  create_table "blockchain_approvals", force: :cascade do |t|
    t.string "currency_id", limit: 20, null: false
    t.string "txid"
    t.string "owner_address", null: false
    t.string "spender_address", null: false
    t.integer "block_number"
    t.integer "status", default: 0, null: false
    t.json "options"
    t.bigint "blockchain_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockchain_id", "txid"], name: "index_blockchain_approvals_on_blockchain_id_and_txid", unique: true
    t.index ["blockchain_id"], name: "index_blockchain_approvals_on_blockchain_id"
    t.index ["currency_id"], name: "index_blockchain_approvals_on_currency_id"
    t.index ["owner_address"], name: "index_blockchain_approvals_on_owner_address"
    t.index ["txid"], name: "index_blockchain_approvals_on_txid"
  end

  create_table "blockchain_currencies", force: :cascade do |t|
    t.bigint "blockchain_id", null: false
    t.string "currency_id", limit: 20, null: false
    t.string "contract_address"
    t.bigint "gas_limit"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "base_factor", null: false
    t.jsonb "options"
    t.decimal "withdraw_fee", precision: 32, scale: 18, default: "0.0", null: false
    t.decimal "min_deposit_amount", precision: 32, scale: 18, default: "0.0", null: false
    t.index ["blockchain_id", "currency_id"], name: "index_blockchain_currencies_on_blockchain_id_and_currency_id", unique: true
    t.index ["currency_id"], name: "index_blockchain_currencies_on_currency_id"
    t.check_constraint "((parent_id IS NOT NULL) AND (contract_address IS NOT NULL)) OR ((parent_id IS NULL) AND (contract_address IS NULL))", name: "blockchain_currencies_contract_address"
  end

  create_table "blockchain_nodes", force: :cascade do |t|
    t.bigint "blockchain_id"
    t.string "client", null: false
    t.string "server_encrypted", limit: 1024
    t.bigint "latest_block_number"
    t.datetime "server_touched_at"
    t.boolean "is_public", default: false, null: false
    t.boolean "has_accounts", default: false, null: false
    t.boolean "use_for_withdraws", default: false, null: false
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockchain_id"], name: "index_blockchain_nodes_on_blockchain_id"
  end

  create_table "blockchains", force: :cascade do |t|
    t.string "key", null: false
    t.string "name"
    t.bigint "height", null: false
    t.string "explorer_address"
    t.string "explorer_transaction"
    t.integer "min_confirmations", default: 6, null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "server_encrypted", limit: 1024
    t.boolean "enable_invoice", default: false, null: false
    t.string "explorer_contract_address"
    t.string "client", null: false
    t.jsonb "client_options", default: {}, null: false
    t.datetime "height_updated_at"
    t.string "client_version"
    t.datetime "high_transaction_price_at"
    t.boolean "disable_collection", default: false, null: false
    t.boolean "allowance_enabled", default: false, null: false
    t.string "address_type"
    t.integer "chain_id"
    t.index ["key"], name: "index_blockchains_on_key", unique: true
    t.index ["status"], name: "index_blockchains_on_status"
  end

  create_table "currencies", id: { type: :string, limit: 15 }, force: :cascade do |t|
    t.string "type", limit: 30, default: "coin", null: false
    t.decimal "withdraw_limit_24h", precision: 36, scale: 18, default: "0.0", null: false
    t.json "options"
    t.boolean "visible", default: true, null: false
    t.integer "precision", limit: 2, default: 8, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "deposit_fee", precision: 36, scale: 18, default: "0.0", null: false
    t.string "icon_url"
    t.decimal "withdraw_limit_72h", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "min_collection_amount", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "min_withdraw_amount", precision: 36, scale: 18, default: "0.0", null: false
    t.string "name"
    t.integer "position", null: false
    t.boolean "deposit_enabled", default: true, null: false
    t.boolean "withdrawal_enabled", default: true, null: false
    t.text "description"
    t.string "homepage"
    t.decimal "price", precision: 36, scale: 18, default: "1.0", null: false
    t.string "cc_code"
    t.string "merged_token_id"
    t.index ["merged_token_id"], name: "index_currencies_on_merged_token_id"
    t.index ["position"], name: "index_currencies_on_position"
    t.index ["visible"], name: "index_currencies_on_visible"
  end

  create_table "currencies_wallets", id: false, force: :cascade do |t|
    t.string "currency_id"
    t.bigint "wallet_id"
    t.boolean "use_in_balance", default: true, null: false
    t.index ["currency_id", "wallet_id"], name: "index_currencies_wallets_on_currency_id_and_wallet_id", unique: true
    t.index ["currency_id"], name: "index_currencies_wallets_on_currency_id"
    t.index ["wallet_id"], name: "index_currencies_wallets_on_wallet_id"
  end

  create_table "deposit_spreads", force: :cascade do |t|
    t.bigint "deposit_id"
    t.string "to_address", null: false
    t.string "txid", null: false
    t.string "currency_id", null: false
    t.decimal "amount", null: false
    t.jsonb "meta", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_deposit_spreads_on_deposit_id"
    t.index ["txid"], name: "index_deposit_spreads_on_txid", unique: true
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "currency_id", limit: 20, null: false
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.decimal "fee", precision: 36, scale: 18, null: false
    t.citext "txid"
    t.string "aasm_state", limit: 30, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.datetime "completed_at", precision: 3
    t.string "type", limit: 30, null: false
    t.integer "txout"
    t.citext "tid", null: false
    t.string "address", limit: 95
    t.integer "block_number"
    t.text "from_addresses"
    t.integer "transfer_type"
    t.json "data"
    t.string "invoice_id"
    t.json "error"
    t.bigint "blockchain_id", null: false
    t.datetime "invoice_expires_at"
    t.boolean "is_locked", default: false, null: false
    t.index ["aasm_state", "member_id", "currency_id"], name: "index_deposits_on_aasm_state_and_member_id_and_currency_id"
    t.index ["blockchain_id", "txid"], name: "index_deposits_on_blockchain_id_and_txid", unique: true, where: "(txid IS NOT NULL)"
    t.index ["blockchain_id"], name: "index_deposits_on_blockchain_id"
    t.index ["currency_id", "invoice_id"], name: "index_deposits_on_currency_id_and_invoice_id", unique: true, where: "(invoice_id IS NOT NULL)"
    t.index ["currency_id", "txid", "txout"], name: "index_deposits_on_currency_id_and_txid_and_txout", unique: true
    t.index ["currency_id"], name: "index_deposits_on_currency_id"
    t.index ["member_id", "txid"], name: "index_deposits_on_member_id_and_txid"
    t.index ["tid"], name: "index_deposits_on_tid"
    t.index ["type"], name: "index_deposits_on_type"
  end

  create_table "engines", force: :cascade do |t|
    t.string "name", null: false
    t.string "driver", null: false
    t.string "uid"
    t.string "url"
    t.string "key_encrypted"
    t.string "secret_encrypted"
    t.string "data_encrypted", limit: 1024
    t.integer "state", default: 1, null: false
  end

  create_table "gas_refuels", force: :cascade do |t|
    t.bigint "blockchain_id", null: false
    t.string "txid", null: false
    t.string "gas_wallet_address", null: false
    t.string "target_address", null: false
    t.bigint "amount", null: false
    t.string "status", null: false
    t.bigint "gas_price", null: false
    t.bigint "gas_limit", null: false
    t.bigint "gas_factor", default: 1, null: false
    t.jsonb "result_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockchain_id", "gas_wallet_address"], name: "index_gas_refuels_on_blockchain_id_and_gas_wallet_address"
    t.index ["blockchain_id", "target_address"], name: "index_gas_refuels_on_blockchain_id_and_target_address"
    t.index ["blockchain_id", "txid"], name: "index_gas_refuels_on_blockchain_id_and_txid", unique: true
    t.index ["blockchain_id"], name: "index_gas_refuels_on_blockchain_id"
  end

  create_table "internal_transfers", force: :cascade do |t|
    t.string "currency_id", null: false
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "credit_currency_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "pointer"
    t.integer "counter"
    t.json "data"
    t.integer "error_code", limit: 2, default: 255, null: false
    t.string "error_message"
    t.datetime "started_at"
    t.datetime "finished_at"
  end

  create_table "markets", force: :cascade do |t|
    t.string "symbol", limit: 20, null: false
    t.string "type", default: "spot", null: false
    t.string "base_unit", limit: 20, null: false
    t.string "quote_unit", limit: 20, null: false
    t.bigint "engine_id", null: false
    t.integer "amount_precision", limit: 2, default: 4, null: false
    t.integer "price_precision", limit: 2, default: 4, null: false
    t.decimal "min_price", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "max_price", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "min_amount", precision: 36, scale: 18, default: "0.0", null: false
    t.integer "position", null: false
    t.json "data"
    t.string "state", limit: 32, default: "enabled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_unit", "quote_unit", "type"], name: "index_markets_on_base_unit_and_quote_unit_and_type", unique: true
    t.index ["base_unit"], name: "index_markets_on_base_unit"
    t.index ["engine_id"], name: "index_markets_on_engine_id"
    t.index ["position"], name: "index_markets_on_position"
    t.index ["quote_unit"], name: "index_markets_on_quote_unit"
    t.index ["symbol", "type"], name: "index_markets_on_symbol_and_type", unique: true
  end

  create_table "member_groups", force: :cascade do |t|
    t.string "key", limit: 25, null: false
    t.integer "open_orders_limit", default: 1, null: false
    t.jsonb "rates_limits", default: {"minut"=>100, "second"=>10}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_member_groups_on_key", unique: true
  end

  create_table "member_transfers", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "currency_id", null: false
    t.string "service", null: false
    t.decimal "amount", null: false
    t.string "key", null: false
    t.text "description", null: false
    t.jsonb "meta", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_member_transfers_on_currency_id"
    t.index ["key"], name: "index_member_transfers_on_key", unique: true
    t.index ["member_id"], name: "index_member_transfers_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid", limit: 32, null: false
    t.integer "level", null: false
    t.string "role", limit: 16, null: false
    t.string "state", limit: 16, null: false
    t.string "group", limit: 32, default: "any", null: false
    t.string "username"
    t.datetime "withdraw_disabled_at"
    t.string "withdraw_disabled_comment"
    t.integer "withdraw_disabled_by"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["uid"], name: "index_members_on_uid", unique: true
    t.index ["username"], name: "index_members_on_username", unique: true, where: "(username IS NOT NULL)"
  end

  create_table "operations_accounts", force: :cascade do |t|
    t.integer "code", null: false
    t.string "type", limit: 10, null: false
    t.string "kind", limit: 30, null: false
    t.string "currency_type", limit: 10, null: false
    t.string "description", limit: 100
    t.string "scope", limit: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_operations_accounts_on_code", unique: true
    t.index ["currency_type"], name: "index_operations_accounts_on_currency_type"
    t.index ["scope"], name: "index_operations_accounts_on_scope"
    t.index ["type", "kind", "currency_type"], name: "index_operations_accounts_on_type_and_kind_and_currency_type", unique: true
    t.index ["type"], name: "index_operations_accounts_on_type"
  end

  create_table "orders", force: :cascade do |t|
    t.string "bid", limit: 20, null: false
    t.string "ask", limit: 20, null: false
    t.string "market_id", limit: 20, null: false
    t.decimal "price", precision: 36, scale: 18
    t.decimal "volume", precision: 36, scale: 18, null: false
    t.decimal "origin_volume", precision: 36, scale: 18, null: false
    t.integer "state", null: false
    t.string "type", limit: 8, null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", precision: 0, null: false
    t.datetime "updated_at", precision: 0, null: false
    t.string "ord_type", limit: 30, null: false
    t.decimal "locked", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "origin_locked", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "funds_received", precision: 36, scale: 18, default: "0.0"
    t.integer "trades_count", default: 0, null: false
    t.decimal "maker_fee", precision: 19, scale: 18, default: "0.0", null: false
    t.decimal "taker_fee", precision: 19, scale: 18, default: "0.0", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "remote_id"
    t.string "market_type", default: "spot", null: false
    t.decimal "trigger_price", precision: 36, scale: 18
    t.datetime "triggered_at"
    t.datetime "canceling_at"
    t.index ["member_id"], name: "index_orders_on_member_id"
    t.index ["state"], name: "index_orders_on_state"
    t.index ["type", "market_id", "market_type"], name: "index_orders_on_type_and_market_id_and_market_type"
    t.index ["type", "member_id"], name: "index_orders_on_type_and_member_id"
    t.index ["type", "state", "market_id", "market_type"], name: "index_orders_on_type_and_state_and_market_id_and_market_type"
    t.index ["type", "state", "member_id"], name: "index_orders_on_type_and_state_and_member_id"
    t.index ["updated_at"], name: "index_orders_on_updated_at"
    t.index ["uuid"], name: "index_orders_on_uuid", unique: true
  end

  create_table "payment_addresses", force: :cascade do |t|
    t.string "address", limit: 95
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret_encrypted", limit: 255
    t.string "details_encrypted", limit: 1024
    t.bigint "member_id"
    t.boolean "remote", default: false, null: false
    t.jsonb "balances", default: {}
    t.datetime "balances_updated_at"
    t.bigint "blockchain_id", null: false
    t.string "collection_state", default: "none", null: false
    t.datetime "collected_at"
    t.datetime "gas_refueled_at"
    t.datetime "last_transfer_try_at"
    t.string "last_transfer_status"
    t.datetime "enqueued_generation_at"
    t.boolean "allowance_enabled", default: false, null: false
    t.datetime "archived_at"
    t.index ["blockchain_id", "address"], name: "index_payment_addresses_on_blockchain_id_and_address", unique: true, where: "(address IS NOT NULL)"
    t.index ["blockchain_id"], name: "index_payment_addresses_on_blockchain_id"
    t.index ["member_id", "blockchain_id"], name: "index_payment_addresses_on_member_id_and_blockchain_id", unique: true, where: "(archived_at IS NULL)"
    t.index ["member_id"], name: "index_payment_addresses_on_member_id"
  end

  create_table "refunds", force: :cascade do |t|
    t.bigint "deposit_id", null: false
    t.string "state", limit: 30, null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_refunds_on_deposit_id"
    t.index ["state"], name: "index_refunds_on_state"
  end

  create_table "stats_member_pnl", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "pnl_currency_id", limit: 20, null: false
    t.string "currency_id", limit: 20, null: false
    t.decimal "total_credit", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_credit_fees", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_debit_fees", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_debit", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_credit_value", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_debit_value", precision: 50, scale: 18, default: "0.0"
    t.decimal "total_balance_value", precision: 50, scale: 18, default: "0.0"
    t.decimal "average_balance_price", precision: 50, scale: 18, default: "0.0"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["pnl_currency_id", "currency_id", "member_id"], name: "index_currency_ids_and_member_id", unique: true
  end

  create_table "stats_member_pnl_idx", force: :cascade do |t|
    t.string "pnl_currency_id", limit: 20, null: false
    t.string "currency_id", limit: 20, null: false
    t.string "reference_type", limit: 255, null: false
    t.bigint "last_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["pnl_currency_id", "currency_id", "last_id"], name: "index_currency_ids_and_last_id"
    t.index ["pnl_currency_id", "currency_id", "reference_type"], name: "index_currency_ids_and_type", unique: true
  end

  create_table "swap_orders", force: :cascade do |t|
    t.string "from_unit", null: false
    t.string "to_unit", null: false
    t.bigint "order_id"
    t.bigint "member_id", null: false
    t.string "market_id", limit: 20, null: false
    t.integer "state", null: false
    t.decimal "from_volume", precision: 36, scale: 18, null: false
    t.decimal "to_volume", precision: 36, scale: 18, null: false
    t.string "request_unit", null: false
    t.decimal "request_volume", precision: 36, scale: 18, null: false
    t.decimal "request_price", precision: 36, scale: 18, null: false
    t.decimal "inverse_price", precision: 36, scale: 18, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_unit"], name: "index_swap_orders_on_from_unit"
    t.index ["market_id"], name: "index_swap_orders_on_market_id"
    t.index ["member_id"], name: "index_swap_orders_on_member_id"
    t.index ["order_id"], name: "index_swap_orders_on_order_id"
    t.index ["request_unit"], name: "index_swap_orders_on_request_unit"
    t.index ["to_unit"], name: "index_swap_orders_on_to_unit"
  end

  create_table "trades", force: :cascade do |t|
    t.decimal "price", precision: 36, scale: 18, null: false
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.bigint "maker_order_id", null: false
    t.bigint "taker_order_id", null: false
    t.string "market_id", limit: 20, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.bigint "maker_id", null: false
    t.bigint "taker_id", null: false
    t.decimal "total", precision: 36, scale: 18, default: "0.0", null: false
    t.string "taker_type", limit: 20, default: "", null: false
    t.string "market_type", default: "spot", null: false
    t.index ["created_at"], name: "index_trades_on_created_at"
    t.index ["maker_id", "market_type", "created_at"], name: "index_trades_on_maker_id_and_market_type_and_created_at"
    t.index ["maker_id", "market_type"], name: "index_trades_on_maker_id_and_market_type"
    t.index ["maker_id"], name: "index_trades_on_maker_id"
    t.index ["maker_order_id"], name: "index_trades_on_maker_order_id"
    t.index ["taker_id", "market_type"], name: "index_trades_on_taker_id_and_market_type"
    t.index ["taker_order_id"], name: "index_trades_on_taker_order_id"
    t.index ["taker_type"], name: "index_trades_on_taker_type"
  end

  create_table "trading_fees", force: :cascade do |t|
    t.string "market_id", limit: 20, default: "any", null: false
    t.string "group", limit: 32, default: "any", null: false
    t.decimal "maker", precision: 7, scale: 6, default: "0.0", null: false
    t.decimal "taker", precision: 7, scale: 6, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "market_type", default: "spot", null: false
    t.index ["group"], name: "index_trading_fees_on_group"
    t.index ["market_id", "market_type", "group"], name: "index_trading_fees_on_market_id_and_market_type_and_group", unique: true
    t.index ["market_id", "market_type"], name: "index_trading_fees_on_market_id_and_market_type"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "currency_id", null: false
    t.string "reference_type"
    t.bigint "reference_id"
    t.string "txid"
    t.string "from_address"
    t.string "to_address"
    t.decimal "amount", precision: 36, scale: 18, default: "0.0", null: false
    t.integer "block_number"
    t.integer "txout"
    t.string "status"
    t.json "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "fee", precision: 36, scale: 18
    t.string "fee_currency_id"
    t.bigint "blockchain_id", null: false
    t.boolean "is_followed", default: false, null: false
    t.integer "to"
    t.integer "from"
    t.integer "kind"
    t.integer "direction"
    t.index ["blockchain_id", "from"], name: "index_transactions_on_blockchain_id_and_from"
    t.index ["blockchain_id", "kind"], name: "index_transactions_on_blockchain_id_and_kind"
    t.index ["blockchain_id", "to"], name: "index_transactions_on_blockchain_id_and_to"
    t.index ["blockchain_id", "txid", "txout"], name: "index_transactions_on_blockchain_id_and_txid_and_txout", unique: true, where: "(txout IS NOT NULL)"
    t.index ["blockchain_id", "txid"], name: "index_transactions_on_blockchain_id_and_txid", unique: true, where: "(txout IS NULL)"
    t.index ["blockchain_id"], name: "index_transactions_on_blockchain_id"
    t.index ["currency_id"], name: "index_transactions_on_currency_id"
    t.index ["fee_currency_id"], name: "index_transactions_on_fee_currency_id"
    t.index ["reference_type", "reference_id"], name: "index_transactions_on_reference_type_and_reference_id"
    t.index ["txid"], name: "index_transactions_on_txid"
  end

  create_table "transfers", force: :cascade do |t|
    t.string "key", limit: 30, null: false
    t.string "description", limit: 255, default: ""
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.integer "category", limit: 2, null: false
    t.index ["key"], name: "index_transfers_on_key", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name", limit: 64
    t.string "address", null: false
    t.string "status", limit: 32
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "max_balance", precision: 36, scale: 18, default: "0.0", null: false
    t.integer "kind", null: false
    t.string "settings_encrypted", limit: 1024
    t.jsonb "balance"
    t.boolean "enable_invoice", default: false, null: false
    t.json "plain_settings"
    t.bigint "blockchain_id", null: false
    t.boolean "use_as_fee_source", default: false, null: false
    t.datetime "balance_updated_at"
    t.index ["blockchain_id"], name: "index_wallets_on_blockchain_id"
    t.index ["kind"], name: "index_wallets_on_kind"
    t.index ["status"], name: "index_wallets_on_status"
  end

  create_table "whitelisted_smart_contracts", force: :cascade do |t|
    t.string "description"
    t.string "address", null: false
    t.string "state", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "blockchain_id", null: false
    t.index ["blockchain_id", "address"], name: "index_whitelisted_smart_contracts_on_blockchain_id_and_address", unique: true
    t.index ["blockchain_id"], name: "index_whitelisted_smart_contracts_on_blockchain_id"
  end

  create_table "withdraw_limits", force: :cascade do |t|
    t.string "group", limit: 32, default: "any", null: false
    t.string "kyc_level", limit: 32, default: "any", null: false
    t.decimal "limit_24_hour", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "limit_1_month", precision: 36, scale: 18, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group", "kyc_level"], name: "index_withdraw_limits_on_group_and_kyc_level", unique: true
    t.index ["group"], name: "index_withdraw_limits_on_group"
    t.index ["kyc_level"], name: "index_withdraw_limits_on_kyc_level"
  end

  create_table "withdraws", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "currency_id", limit: 20, null: false
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.decimal "fee", precision: 36, scale: 18, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.datetime "completed_at", precision: 3
    t.citext "txid"
    t.string "aasm_state", limit: 30, null: false
    t.decimal "sum", precision: 36, scale: 18, null: false
    t.string "type", limit: 30, null: false
    t.citext "tid", null: false
    t.string "rid", limit: 256, null: false
    t.integer "block_number"
    t.string "note", limit: 256
    t.json "error"
    t.bigint "beneficiary_id"
    t.integer "transfer_type"
    t.json "metadata"
    t.string "remote_id"
    t.bigint "blockchain_id", null: false
    t.jsonb "tx_dump"
    t.boolean "is_locked", default: false, null: false
    t.index ["aasm_state"], name: "index_withdraws_on_aasm_state"
    t.index ["blockchain_id"], name: "index_withdraws_on_blockchain_id"
    t.index ["currency_id", "txid"], name: "index_withdraws_on_currency_id_and_txid", unique: true
    t.index ["currency_id"], name: "index_withdraws_on_currency_id"
    t.index ["member_id"], name: "index_withdraws_on_member_id"
    t.index ["tid"], name: "index_withdraws_on_tid"
    t.index ["type"], name: "index_withdraws_on_type"
  end

  add_foreign_key "blockchain_approvals", "blockchains"
  add_foreign_key "blockchain_currencies", "blockchain_currencies", column: "parent_id"
  add_foreign_key "blockchain_currencies", "blockchains"
  add_foreign_key "blockchain_currencies", "currencies"
  add_foreign_key "blockchain_nodes", "blockchains"
  add_foreign_key "currencies", "currencies", column: "merged_token_id"
  add_foreign_key "deposit_spreads", "deposits"
  add_foreign_key "gas_refuels", "blockchains"
  add_foreign_key "member_transfers", "members"
  add_foreign_key "members", "members", column: "withdraw_disabled_by"
  add_foreign_key "withdraws", "blockchains"
end