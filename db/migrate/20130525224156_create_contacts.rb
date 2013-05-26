class CreateContacts < ActiveRecord::Migration
  def change
  	create_table :user_contacts do |t|
  		t.references	:user, :contact
  		t.boolean			:blocked, :default => false
  		t.timestamps
  	end
  end
end
