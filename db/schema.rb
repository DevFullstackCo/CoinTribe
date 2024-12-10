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

ActiveRecord::Schema[8.0].define(version: 2024_12_10_163839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alert_prices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "crypto_id", null: false
    t.float "alert_price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_id"], name: "index_alert_prices_on_crypto_id"
    t.index ["user_id"], name: "index_alert_prices_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "cryptos", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "symbol"
    t.bigint "volume_24h"
    t.float "variation_24h"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "volume_token_24h"
    t.string "logo_url"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "crypto_id", null: false
    t.bigint "user_id", null: false
    t.boolean "is_favorite", default: false, null: false
    t.float "quantity", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_id"], name: "index_favorites_on_crypto_id"
    t.index ["user_id", "crypto_id"], name: "index_favorites_on_user_id_and_crypto_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "is_read?", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "crypto_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_id"], name: "index_posts_on_crypto_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_admin"
    t.boolean "is_subscriber"
    t.string "username"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted_cgu", default: false, null: false
    t.boolean "accepted_privacy_policy", default: false, null: false
    t.datetime "accepted_at"
    t.string "ethereum_address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "crypto_id"
    t.bigint "user_id"
    t.boolean "is_bullished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_id"], name: "index_votes_on_crypto_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  create_table "votes_histories", force: :cascade do |t|
    t.bigint "crypto_id"
    t.bigint "user_id"
    t.boolean "is_bullished"
    t.date "voted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crypto_id"], name: "index_votes_histories_on_crypto_id"
    t.index ["user_id"], name: "index_votes_histories_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alert_prices", "cryptos"
  add_foreign_key "alert_prices", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "cryptos"
  add_foreign_key "favorites", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "posts", "cryptos"
  add_foreign_key "posts", "users"
  add_foreign_key "votes", "cryptos"
  add_foreign_key "votes", "users"
  add_foreign_key "votes_histories", "cryptos"
  add_foreign_key "votes_histories", "users"
end
