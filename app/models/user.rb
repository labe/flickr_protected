class User < ActiveRecord::Base
	has_many	:albums, :foreign_key => :creator_id
	has_many	:photos, :through => :albums

  has_many  :user_contacts, :dependent => :destroy    ## user_contacts will be deleted if user is deleted
  has_many  :contacts, :through => :user_contacts, :class_name => "User", :foreign_key => :contact_id

  has_many  :is_a_contacts, :class_name => "UserContact", :foreign_key => :contact_id
  has_many  :users, :through => :is_a_contacts, :foreign_key => :user_id

	validates :username, :presence => true, :length => { :minimum => 3, 
            :message => "must be at least 3 characters, fool!" }, :uniqueness => true
  validates :email, :presence => true, :format => {:with =>  /\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,3}/},
            :uniqueness => true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end
  
  def self.create(params={})
    @user = User.new(:email => params[:email], :username => params[:username])
    @user.password = params[:password]
    @user.save!
    @user
  end

  def self.authenticate(params)
    user = User.find_by_username(params[:username])
    (user && user.password == params[:password]) ? user : nil
  end

  def is_private?
    return self.private
  end

  def is_contact?(user)
    return true if self == user
    return user.contacts.include?(self)
  end 

  def is_blocked?(user)
    return false if self == user
    return UserContact.where(:user_id => user.id, :contact_id => self.id).first.blocked if UserContact.where(:user_id => user.id, :contact_id => self.id).any?
  end

  def add_contact
    
  end

end
