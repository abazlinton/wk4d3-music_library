require_relative '../models/artist'


get '/artists'  do
  @artists = Artist.all
  erb (:'artist/index')
end

get '/artists/new' do
  erb(:'artist/new')
end


post '/artists' do
  @artist = Artist.new( params )
  @artist.save
  erb(:'artist/create')
end

get '/artists/:id' do
  @artist = Artist.find( params[:id] )
  erb(:'artist/show')
end

