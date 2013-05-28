get '/' do
	session[:last_page] = '/'
  erb :index
end

get '/auto' do
	erb :auto
end

post '/auto' do
	users = User.all.map { |user| user.username }
	return users.to_json
end