# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130112111828) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "ev_date"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "poll_options", :force => true do |t|
    t.string   "option"
    t.integer  "poll_id"
    t.integer  "poll_responses_count", :default => 0
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "poll_options", ["poll_id"], :name => "index_poll_options_on_poll_id"

  create_table "poll_responses", :force => true do |t|
    t.integer  "poll_id"
    t.integer  "user_id"
    t.integer  "poll_option_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "poll_responses", ["poll_id"], :name => "index_poll_responses_on_poll_id"
  add_index "poll_responses", ["poll_option_id"], :name => "index_poll_responses_on_poll_option_id"
  add_index "poll_responses", ["user_id"], :name => "index_poll_responses_on_user_id"

  create_table "polls", :force => true do |t|
    t.string   "question"
    t.integer  "votes_count", :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "replies", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "replies", ["topic_id"], :name => "index_replies_on_topic_id"
  add_index "replies", ["user_id"], :name => "index_replies_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "last_poster_id"
    t.datetime "last_post_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "administrator"
    t.boolean  "moderator"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
