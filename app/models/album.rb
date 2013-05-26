class Album < ActiveRecord::Base
  has_many :photos
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id

end
