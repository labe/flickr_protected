class AddPendingCol < ActiveRecord::Migration
  def up 
  	add_column	:user_contacts, :pending, :boolean
  end

  def down
  	remove_column	:user_contacts, :pending, :boolean  	
  end
end
