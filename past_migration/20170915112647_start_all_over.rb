class StartAllOver < ActiveRecord::Migration[5.1]
  def change
    create_table "articles", force: :cascade do |t|
      t.string "title"
      t.string "image"
      t.string "url"
      t.string "source"
      t.datetime "published_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "category_id"
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
    end
  
    create_table "favorites", force: :cascade do |t|
      t.integer "user_id"
      t.integer "tag_id"
    end
  
    create_table "likes", force: :cascade do |t|
      t.integer "user_id"
      t.integer "comment_id"
      t.integer "post_id"
      t.integer "reply_id"
      t.string "target_type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "target_user_id"
      t.integer "article_id"
    end
  
    create_table "posts", force: :cascade do |t|
      t.integer "user_id"
      t.text "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "article_id"
      t.integer "category_id"
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
    end
    
    create_table "users", force: :cascade do |t|
      t.string "name"
      t.string "image"
      t.string "provider"
      t.string "uid"
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
      t.string "shoulder_name", default: "Newspartyの村人X"
      t.text "about", default: ""
      t.string "cover"
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
