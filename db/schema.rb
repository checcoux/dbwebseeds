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

ActiveRecord::Schema.define(version: 20160717085810) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "column_images", force: :cascade do |t|
    t.text     "descrizione"
    t.integer  "column_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "immagine_file_name"
    t.string   "immagine_content_type"
    t.integer  "immagine_file_size"
    t.datetime "immagine_updated_at"
    t.text     "titolo"
    t.text     "collegamento"
  end

  add_index "column_images", ["column_id"], name: "index_column_images_on_column_id"

  create_table "columns", force: :cascade do |t|
    t.integer  "ordine"
    t.text     "contenuto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_id"
    t.integer  "larghezza"
  end

  add_index "columns", ["row_id"], name: "index_columns_on_row_id"

  create_table "pages", force: :cascade do |t|
    t.string   "titolo",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  add_index "pages", ["section_id"], name: "index_pages_on_section_id"

  create_table "rows", force: :cascade do |t|
    t.integer  "ordine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
    t.boolean  "estesa",                       default: false
    t.string   "colore_sfondo"
    t.string   "immagine_sfondo_file_name"
    t.string   "immagine_sfondo_content_type"
    t.integer  "immagine_sfondo_file_size"
    t.datetime "immagine_sfondo_updated_at"
  end

  add_index "rows", ["page_id"], name: "index_rows_on_page_id"

  create_table "sections", force: :cascade do |t|
    t.string   "titolo",      limit: 255
    t.text     "descrizione"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
