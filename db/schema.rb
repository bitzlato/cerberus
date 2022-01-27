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

ActiveRecord::Schema.define(version: 2022_01_24_093439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.string "applicant_id", null: false
    t.string "inspection_id", null: false
    t.string "user_uid", null: false
    t.string "source_key"
    t.datetime "start_date"
    t.datetime "create_date"
    t.integer "status"
    t.string "review_status"
    t.string "moderation_comment"
    t.string "client_comment"
    t.string "review_answer"
    t.string "review_reject_type"
    t.string "webhook_type"
    t.json "raw_request", default: {}
    t.json "fixed_info", default: {}
    t.json "reject_labels", default: []
  end

end
