class CreateAlbums < ActiveRecord::Migration
  def change
  	create_table :albums do |t|
  		t.references		:creator
  		t.string				:name
  		t.string				:description
  		t.timestamps
  	end
  end
end
