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

ActiveRecord::Schema.define(version: 20180130160327) do

  create_table "attachments", force: :cascade do |t|
    t.string   "titolo"
    t.text     "descrizione"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "allegato_file_name"
    t.string   "allegato_content_type"
    t.integer  "allegato_file_size"
    t.datetime "allegato_updated_at"
    t.integer  "section_id"
    t.text     "parole"
    t.string   "immagine_file_name"
    t.string   "immagine_content_type"
    t.integer  "immagine_file_size"
    t.datetime "immagine_updated_at"
  end

  add_index "attachments", ["section_id"], name: "index_attachments_on_section_id"

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
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "immagine_file_name"
    t.string   "immagine_content_type"
    t.integer  "immagine_file_size"
    t.datetime "immagine_updated_at"
    t.text     "titolo"
    t.text     "collegamento"
    t.integer  "ordine",                default: 0
  end

  add_index "column_images", ["column_id"], name: "index_column_images_on_column_id"

  create_table "columns", force: :cascade do |t|
    t.integer  "ordine"
    t.text     "contenuto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_id"
    t.integer  "larghezza"
    t.integer  "fonte",           default: 0
    t.integer  "page_id",         default: 0
    t.boolean  "autocrop",        default: false
    t.string   "padding",         default: ""
    t.boolean  "condivisa",       default: true
    t.integer  "columnable_id"
    t.string   "columnable_type"
  end

  add_index "columns", ["columnable_type", "columnable_id"], name: "index_columns_on_columnable_type_and_columnable_id"
  add_index "columns", ["page_id"], name: "index_columns_on_page_id"
  add_index "columns", ["row_id"], name: "index_columns_on_row_id"

  create_table "data", force: :cascade do |t|
    t.integer  "instance_id"
    t.integer  "property_id"
    t.string   "valore"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "data", ["instance_id"], name: "index_data_on_instance_id"
  add_index "data", ["property_id"], name: "index_data_on_property_id"

  create_table "entities", force: :cascade do |t|
    t.string   "titolo"
    t.boolean  "nativo",                                              default: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "slug"
    t.integer  "user_id"
    t.string   "landing_page"
    t.string   "plurale"
    t.boolean  "vetrina",                                             default: false
    t.integer  "stato",                                               default: 0
    t.text     "descrizione"
    t.string   "date",                                                default: ""
    t.string   "immagine_file_name"
    t.string   "immagine_content_type"
    t.integer  "immagine_file_size"
    t.datetime "immagine_updated_at"
    t.string   "tipo"
    t.integer  "limite",                                              default: 0
    t.decimal  "caparra",                     precision: 6, scale: 2, default: 0.0
    t.decimal  "prezzo",                      precision: 6, scale: 2, default: 0.0
    t.boolean  "applica_limiti",                                      default: false
    t.boolean  "creazione_multipla",                                  default: false
    t.text     "testo_pagamento"
    t.boolean  "applica_limiti_appartenenza",                         default: false
    t.integer  "ordine",                                              default: 0
    t.text     "descrizione_lunga"
    t.string   "icona_on_file_name"
    t.string   "icona_on_content_type"
    t.integer  "icona_on_file_size"
    t.datetime "icona_on_updated_at"
    t.string   "icona_off_file_name"
    t.string   "icona_off_content_type"
    t.integer  "icona_off_file_size"
    t.datetime "icona_off_updated_at"
    t.integer  "capogruppo_gratuito",                                 default: 0
  end

  add_index "entities", ["slug"], name: "index_entities_on_slug", unique: true
  add_index "entities", ["titolo"], name: "index_entities_on_titolo"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "instances", force: :cascade do |t|
    t.integer  "entity_id"
    t.integer  "section_id"
    t.string   "tags"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.integer  "appartenenza_id", default: 0
    t.string   "proxy",           default: ""
  end

  create_table "pages", force: :cascade do |t|
    t.string   "titolo",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.boolean  "home",                     default: false
    t.boolean  "header",                   default: false
    t.boolean  "footer",                   default: false
    t.string   "slug"
    t.boolean  "modello",                  default: false
    t.boolean  "articolo",                 default: false
    t.boolean  "visibile",                 default: true
    t.datetime "published_at",             default: '2016-08-17 08:12:10'
    t.text     "abstract"
  end

  add_index "pages", ["section_id"], name: "index_pages_on_section_id"
  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true

  create_table "photoalbums", force: :cascade do |t|
    t.string   "titolo"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "section_id"
    t.text     "parole"
    t.string   "slug"
    t.integer  "copertina",  default: 0
  end

  add_index "photoalbums", ["section_id"], name: "index_photoalbums_on_section_id"
  add_index "photoalbums", ["slug"], name: "index_photoalbums_on_slug", unique: true

  create_table "photos", force: :cascade do |t|
    t.integer  "photoalbum_id"
    t.string   "immagine"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string  "nome"
    t.string  "tipo"
    t.boolean "nativo",       default: false
    t.integer "entity_id"
    t.boolean "maiuscolo",    default: false
    t.boolean "obbligatorio", default: false
    t.boolean "riservata",    default: false
    t.text    "condizioni"
    t.integer "ordine"
    t.text    "descrizione"
    t.string  "placeholder"
    t.boolean "indice",       default: false
  end

  add_index "properties", ["entity_id"], name: "index_properties_on_entity_id"
  add_index "properties", ["nome"], name: "index_properties_on_nome"

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
    t.string   "visibilita",                   default: ""
  end

  add_index "rows", ["page_id"], name: "index_rows_on_page_id"

  create_table "sections", force: :cascade do |t|
    t.string   "titolo",      limit: 255
    t.text     "descrizione"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "principale",              default: false
    t.string   "percorso"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "nome"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tags", ["taggable_type", "taggable_id"], name: "index_tags_on_taggable_type_and_taggable_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "section_id"
    t.boolean  "designer",               default: false
    t.boolean  "aggiornato",             default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
