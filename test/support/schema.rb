ActiveRecord::Schema.define(:version => 0) do

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.string  "authorizable_id"
    t.boolean "system", :default=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "users", :force => true do |t| 
    t.string   "name",     :limit => 40
    t.string   "email",     :limit => 40
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

