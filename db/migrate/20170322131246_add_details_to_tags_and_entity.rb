class AddDetailsToTagsAndEntity < ActiveRecord::Migration
  def change
  	add_column :entities ,:count, :integer
  	add_column :tags ,:count, :integer
  end
end
