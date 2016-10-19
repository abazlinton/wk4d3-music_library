require( 'pg' )
require_relative( '../db/sql_runner' )
require_relative( '../models/album' )

class Artist

  attr_reader( :id, :name )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  #CREATE
  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{ @name }') RETURNING *"
    artist = SqlRunner.run( sql ).first
    @id = artist['id']
  end

  #SHOW
  def self.find( id )
    sql = "SELECT * from artists WHERE id = #{id}"
    artist_data = SqlRunner.run(sql).first
    artist = Artist.new( artist_data )
    return artist
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{ @id }"
    albums = SqlRunner.run( sql )
    result = albums.map { |a| Album.new( a ) }
    return result
  end

  #INDEX
  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run( sql )
    result = artists.map { |a| Artist.new( a ) }
    return result
  end

end
