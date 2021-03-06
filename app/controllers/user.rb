get '/login' do
  if session[:last_page] == '/create_album'
      erb :login, :locals => {:errors => "You must be logged in to do that."}    
	else
    erb :login, :locals => {:errors => nil}
  end
end

post '/login' do
  if user = User.authenticate(params[:user])
    session[:username] = user.username
    redirect "#{session[:last_page]}"
  else
    erb :login, :locals => {:errors => "You done messed up."}
  end
end

post '/create_account' do
    if user = User.create(params[:user])
    session[:username] = user.username 
    redirect (session[:last_page] == '/' ? "users/#{user.username}" : session[:last_page])
  else
    erb :login, :locals => {:errors => "You done messed up."}
  end
end

get '/logout' do
	session[:username] = nil
	redirect '/'
end

## does not throw UI error if username does not exist. Yet.
## UPDATE: route is updated to throw error but this is untested 
get '/users/:username/?' do

  if user = User.find_by_username(params[:username])
    if  (user.private? && !current_user) || 
        (user.private? && current_user != user && !current_user.is_contact?(user)) || 
        (current_user && current_user.is_blocked?(user))
      erb :error_b
    elsif   !user.private? || 
            current_user == user || 
            current_user.is_contact?(user)
      erb :user, :locals => {:user => user}
    end
  else
    erb :error
  end
end

get '/users/:username/settings/?' do
  if current_user == User.find_by_username(params[:username])
    erb :user_settings, :locals => {:user => User.find_by_username(params[:username]), :errors => nil}
  else
    erb :error
  end
end

# remember to change this. or don't, whatever.
get '/users/:username/add_as_contact' do
  "DIAL IT BACK, KID. Implement this later when you've figured out how to refactor your code explosion."
end

post '/users/:username/settings/privacy' do
  if current_user == User.find_by_username(params[:username])
    params[:privacy] == "true" && current_user.private == false ? User.update(current_user.id, :private => true) : User.update(current_user.id, :private => false) 
    redirect "/users/#{current_user.username}/settings"
  else
    erb :error
  end
end

post '/users/:username/settings/add_contact' do
  current_user.add_contact
  erb :user_settings, :locals => {:user => User.find_by_username(params[:username]), :errors => "User cannot be found :("}
end

post '/users/:username/settings/block_user' do
  if current_user == User.find_by_username(params[:username])
    if contact = User.find_by_username(params[:user]) || contact = User.find_by_email(params[:user])
      current_user.contacts << contact
      id = UserContact.where(:user_id => current_user.id, :contact_id => contact.id).first
      UserContact.update(id, :blocked => true)
      redirect "/users/#{current_user.username}/settings"
    else
      erb :user_settings, :locals => {:user => User.find_by_username(params[:username]), :errors => "User cannot be found :("}
    end
  else
    erb :error
  end
end