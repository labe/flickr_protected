get '/create_album' do
	if current_user
		erb :upload
	else
		session[:last_page] = '/create_album'
		redirect '/login'
	end
end

post '/publish' do
	album = Album.create(params[:album])
	Album.update(album.id, :creator => current_user)

	params[:photo].each do |key, image_hash|
		album.photos << Photo.create(:file => image_hash)
	end
	redirect "/#{current_user.username}/albums/#{album.id}"
end

get '/:username/albums/:album_id' do
	user = User.find_by_username(params[:username])
  if  (user.private? && !current_user) || 
      (user.private? && current_user != user && !current_user.is_contact?(user)) || 
      (current_user && current_user.is_blocked?(user))
    erb :error
  elsif   !user.private? || 
          current_user == user || 
          current_user.is_contact?(user)
    erb :album, :locals => {:album => Album.find(params[:album_id])}
  end
end

