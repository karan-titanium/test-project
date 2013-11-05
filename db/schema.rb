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

ActiveRecord::Schema.define(:version => 20130927101003) do

  create_table "campaign_exams", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "exam_id"
    t.string   "stage"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campaign_link_clicks", :force => true do |t|
    t.integer  "campaign_link_id"
    t.datetime "date"
    t.string   "referrer"
    t.boolean  "unique"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "campaign_links", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campaign_traits", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "trait_id"
    t.integer  "weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.datetime "date_activated"
    t.datetime "date_inactive"
    t.string   "campaign_name"
    t.string   "reference"
    t.string   "status"
    t.integer  "company_id"
    t.string   "title"
    t.text     "summary"
    t.text     "details"
    t.datetime "deadline_application"
    t.datetime "deadline_forward"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "cdn_files", :force => true do |t|
    t.integer  "uploaded_by"
    t.string   "filename"
    t.string   "ext"
    t.string   "mimetype"
    t.integer  "size"
    t.string   "cf_filename"
    t.string   "file_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "phone"
    t.string   "website"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_town"
    t.string   "address_country"
    t.string   "address_postcode"
    t.integer  "contact"
    t.boolean  "whitelable"
    t.string   "subdomain"
    t.string   "displayname"
    t.text     "profile"
    t.integer  "logo"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "company_logos", :force => true do |t|
    t.integer  "company_id"
    t.integer  "cdn_file_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contact_attachments", :force => true do |t|
    t.integer  "contact_log_id"
    t.boolean  "private"
    t.integer  "cdn_file_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "contact_logs", :force => true do |t|
    t.integer  "from"
    t.integer  "to"
    t.integer  "campaign_id"
    t.string   "method"
    t.datetime "datecontact"
    t.text     "subject"
    t.text     "details"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "email_tags", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "email_templates", :force => true do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "content_html"
    t.text     "content_plain"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "exam_tests", :force => true do |t|
    t.integer  "exam_id"
    t.integer  "test_id"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.boolean  "generic"
    t.text     "intro"
    t.integer  "rest"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "interviews", :force => true do |t|
    t.datetime "date"
    t.integer  "candidate"
    t.integer  "interviewer"
    t.integer  "campaign"
    t.string   "interview_type"
    t.text     "notes"
    t.integer  "audiofile"
    t.integer  "transcript"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "itskills", :force => true do |t|
    t.string   "name"
    t.string   "status",     :default => "unconfirmed"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "log_systems", :force => true do |t|
    t.string   "event_type"
    t.integer  "user_id"
    t.string   "ip"
    t.text     "message"
    t.text     "controller"
    t.text     "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.string   "table"
    t.string   "table_col"
    t.integer  "table_id"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "subject_class"
    t.string   "action"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "qualification_grades", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "qualification_type_id"
    t.integer  "order"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "qualification_locations", :force => true do |t|
    t.string   "name"
    t.string   "status",     :default => "unconfirmed"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "qualification_subjects", :force => true do |t|
    t.string   "name"
    t.string   "status",     :default => "unconfirmed"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "qualification_types", :force => true do |t|
    t.string   "name"
    t.string   "status",     :default => "unconfirmed"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "question_categories", :force => true do |t|
    t.string   "name"
    t.integer  "trait_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_files", :force => true do |t|
    t.integer  "question_id"
    t.integer  "cdn_file_id"
    t.integer  "order"
    t.string   "title"
    t.integer  "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "question_options", :force => true do |t|
    t.integer  "question_part_id"
    t.integer  "order"
    t.text     "content"
    t.integer  "points"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "question_parts", :force => true do |t|
    t.integer  "question_id"
    t.integer  "order"
    t.text     "content"
    t.string   "question_part_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "question_category_id"
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.text     "content"
    t.text     "explanation"
    t.string   "difficulty"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "role_permissions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "role_users", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "setting_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "system_settings", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.string   "description"
    t.text     "value"
    t.string   "setting_type"
    t.boolean  "editable"
    t.integer  "setting_category_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "test_questions", :force => true do |t|
    t.integer  "test_id"
    t.integer  "question_id"
    t.integer  "order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tests", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "status"
    t.integer  "duration"
    t.integer  "example"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "traits", :force => true do |t|
    t.string   "status"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "transcript_requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "interview_id"
    t.datetime "notified"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "sitting"
    t.datetime "date"
    t.integer  "test_id"
    t.integer  "question_option_id"
    t.text     "answer"
    t.integer  "points"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "user_campaigns", :force => true do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "date"
    t.datetime "date_forwarded"
    t.datetime "date_reviewed"
    t.integer  "source_staff"
    t.integer  "source_link"
    t.string   "status"
    t.datetime "phone_date"
    t.string   "phone_result"
    t.text     "phone_notes"
    t.datetime "interview_date"
    t.string   "interview_result"
    t.text     "interview_notes"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_companies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.boolean  "current"
    t.boolean  "clientcontact"
    t.datetime "from"
    t.datetime "untill"
    t.string   "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_exams", :force => true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.string   "status"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_files", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_file_type"
    t.integer  "cdn_file_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "user_itskills", :force => true do |t|
    t.integer  "user_id"
    t.integer  "itskill_id"
    t.integer  "experience"
    t.string   "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_languages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.string   "spoken"
    t.string   "written"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_otherskills", :force => true do |t|
    t.integer  "user_id"
    t.string   "skill"
    t.integer  "experience"
    t.string   "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo"
    t.string   "passport"
    t.string   "eligableuk"
    t.text     "eligabledetails"
    t.string   "gender"
    t.string   "number_mob"
    t.string   "number_alt"
    t.string   "contact_method"
    t.string   "contact_time"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_town"
    t.string   "address_country"
    t.string   "address_postcode"
    t.integer  "salary_current"
    t.integer  "salary_target"
    t.string   "uk_driving_licence"
    t.string   "employed"
    t.datetime "date_of_birth"
    t.datetime "reminderemail1"
    t.datetime "reminderemail2"
    t.datetime "reminderemail3"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "user_qualifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "qualification_type_id"
    t.integer  "qualification_location_id"
    t.integer  "qualification_subject_id"
    t.integer  "qualification_grade_id"
    t.integer  "year"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "user_traits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "trait_id"
    t.integer  "score"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.string   "user_type"
    t.integer  "role_id"
    t.datetime "last_updated_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.integer  "user_id"
    t.string   "ip"
    t.string   "msg"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
