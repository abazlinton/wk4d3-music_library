require_relative '../models/album'


get '/albums'  do
  @albums = Album.all
  erb (:'album/index')
end

get '/albums/new' do
  erb(:'album/new')
end


post '/albums' do
  @album = Album.new( params )
  @album.save
  erb(:'album/create')
end

get '/albums/:id' do
  @album = Album.find( params[:id] )
  erb(:'album/show')
end

get '/albums/new/:artist_id' do
  @artist_id = params[:artist_id]
  erb(:'album/new')
end