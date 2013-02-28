class CreateSectionEdits < ActiveRecord::Migration
  def change
    create_table :section_edits do |t|
		#another example of many to many rich associations
		#this is equivelant to a joint table
		t.references :admin_user
		t.references :section
		t.string "summary" 
      t.timestamps
    end
	add_index :section_edits, ['admin_user_id', 'section_id']
  end
end
