require( 'pg' )
require_relative('../db/sql_runner')

class Album

  attr_reader( :id, :name, :artist_id )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @artist_id = options['artist_id'].to_i
  end

  #CREATE
  def save()
    sql = "INSERT INTO albums (name, artist_id) VALUES ('#{ @name }', #{ @artist_id }) RETURNING *"
    album = SqlRunner.run( sql ).first
    @id = album['id'].to_i
  end

  #SHOW
  def artist()
    sql = "SELECT * FROM artists WHERE id = #{ @artist_id }"
    artist = SqlRunner.run( sql )
    result = Artist.new( artist.first )
    return result
  end

  def self.find( id )
    sql = "SELECT * from albums WHERE id = #{id}"
    album_data = SqlRunner.run(sql).first
    album = Album.new( album_data )
    return album
  end

  #INDEX
  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run( sql )
    result = albums.map { |s| Album.new( s ) }
    return result
  end

  def update( params )
    sql = "UPDATE albums SET name = '#{params[:name]}', artist_id = #{params[:artist_id]} WHERE id = #{id}"
  end

end
