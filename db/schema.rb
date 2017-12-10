# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171210124120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.string "url"
    t.string "source"
    t.datetime "published_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "posts_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "country_id"
    t.integer "e_indecator", default: 0
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_tables", force: :cascade do |t|
    t.integer "post_id"
    t.integer "article_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "replies_count", default: 0, null: false
    t.integer "article_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "language_id"
    t.string "code"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tag_id"
  end

  create_table "feed_notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.boolean "check", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "country_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "message"
    t.string "path"
    t.string "notification_type"
    t.boolean "check", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_user_id"
    t.integer "post_id"
    t.integer "comment_id"
    t.integer "reply_id"
    t.boolean "everyone", default: false
  end

  create_table "post_drafts", force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.integer "article_id"
    t.integer "category_id"
    t.integer "country_id"
    t.boolean "fake_news_report", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide", default: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_id"
    t.integer "category_id"
    t.integer "likes_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "country_id"
    t.boolean "fake_news_report", default: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_id"], name: "index_relationships_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
    t.index ["following_id"], name: "index_relationships_on_following_id"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id"
    t.integer "reportable_id"
    t.string "reportable_type"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "check", default: false
    t.integer "country_id"
    t.index ["reportable_id", "reportable_type"], name: "index_reports_on_reportable_id_and_reportable_type"
  end

  create_table "social_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "url"
    t.string "description"
    t.text "other"
    t.text "credentials"
    t.text "raw_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "access_secret"
    t.index ["provider", "uid"], name: "index_social_profiles_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_social_profiles_on_user_id"
  end

  create_table "tagged_posts", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "post_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "weekly_posts_count", default: 0, null: false
    t.integer "country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "gender"
    t.text "about", default: ""
    t.string "cover"
    t.integer "followers_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.integer "liked_count", default: 0, null: false
    t.integer "weekly_liked_count", default: 0, null: false
    t.integer "country_id", default: 2
    t.integer "language_id", default: 1
    t.boolean "facebook_post", default: false
    t.boolean "linkedin_post", default: false
    t.boolean "twitter_post", default: false
    t.integer "twitter_follower", default: 0
    t.boolean "admin", default: false
    t.string "credential"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "social_profiles", "users"
end
