class EntitiesTags < ActiveRecord::Migration
  def change
  	create_table :entities_tags, :id =>false do |t|
  	  		t.integer :entity_id
  	  		t.integer :tag_id
  	  	end
  end
end
