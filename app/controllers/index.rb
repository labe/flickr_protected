get '/' do
	session[:last_page] = '/'
  erb :index
end

