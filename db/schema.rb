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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160324082904) do

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "columns", force: true do |t|
    t.integer  "ordine"
    t.text     "contenuto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_id"
    t.integer  "larghezza"
  end

  add_index "columns", ["row_id"], name: "index_columns_on_row_id"

  create_table "pages", force: true do |t|
    t.string   "titolo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  add_index "pages", ["section_id"], name: "index_pages_on_section_id"

  create_table "rows", force: true do |t|
    t.integer  "ordine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
    t.boolean  "estesa",     default: false
  end

  add_index "rows", ["page_id"], name: "index_rows_on_page_id"

  create_table "sections", force: true do |t|
    t.string   "titolo"
    t.text     "descrizione"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
