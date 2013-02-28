class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
		#t.integer "id"  dont worry! Rails by default takes care of id for us
		t.string "first_name", :limit=>25
		t.string "last_name", :limit=>50
		t.string "email", :default=>"", :null=>false
		t.text "password", :limit=>40
		#t.datetime "created_at"
		#t.datetime "updated_at"
		
      t.timestamps #rail takes care of both created at and updated at in timestamps
    end
  end
end
