def current_user
  User.where(:username => session[:username]).first
end
