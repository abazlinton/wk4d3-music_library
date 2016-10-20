require_relative '../models/artist'
require 'pry-byebug'



get '/artists'  do
  @artists = Artist.all
  erb(:'artists/index')
end

get '/artists/new' do
  erb(:'artists/new')
end


post '/artists' do
  @artist = Artist.new( params )
  @artist.save
  erb(:'artists/create')
end

get '/artists/:id' do
  @artist = Artist.find( params[:id] )
  erb(:'artists/show')
end

get '/artists/:id/edit' do 
  @artist = Artist.find( params[:id] )
  @old_name = @artist.name
  erb(:'artists/edit')

end

put '/artists/:id' do
  @artist = Artist.new( params )
  @old_name = params[:old_name]
  @new_artist = Artist.new( @artist.update( params ) )
  erb(:'artists/update')
end

delete '/artists/:id' do
  Artist.destroy( params[:id] )
  redirect to('/artists')
end
