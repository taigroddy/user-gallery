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

ActiveRecord::Schema.define(version: 20_220_514_061_157) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'galleries', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'name', null: false
    t.text 'short_description', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_galleries_on_name', unique: true
    t.index ['user_id'], name: 'index_galleries_on_user_id'
  end

  create_table 'photos', force: :cascade do |t|
    t.bigint 'gallery_id', null: false
    t.string 'name'
    t.datetime 'shooting_date'
    t.text 'short_description'
    t.string 'image_file_name', null: false
    t.string 'image_content_type', null: false
    t.bigint 'image_file_size', null: false
    t.datetime 'image_updated_at', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['gallery_id'], name: 'index_photos_on_gallery_id'
    t.index ['name'], name: 'index_photos_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'galleries', 'users'
  add_foreign_key 'photos', 'galleries'
end
