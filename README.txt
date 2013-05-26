DBc default Sinatra skeleton with BONUS FEATURES:

* rake db:yolo
* rake db:fuckit
* rake db:console

* BCrypt
* Faker

* user_helper.rb // current_user method to check login state


helpful things to include in User model:

  validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters, fool!" }, :uniqueness => true
  validates :email, :uniqueness => true, :format => /\w+@\w+\.\w{2,3}/ 

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end
  
  def self.create(params={})
    @user = User.new(:email => params[:email], :name => params[:name])
    @user.password = params[:password]
    @user.save!
    @user
  end

  def self.authenticate(params)
    user = User.find_by_name(params[:name])
    (user && user.password == params[:password]) ? user : nil
  end