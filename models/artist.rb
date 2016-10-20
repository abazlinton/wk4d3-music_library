require( 'pg' )
require_relative( '../db/sql_runner' )
require_relative( '../models/album' )

class Artist

  attr_reader( :id, :name )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  #CREATE
  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{ @name }') RETURNING *"
    artist = SqlRunner.run( sql ).first
    @id = artist['id'].to_i
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

  def update( params )
    sql = "UPDATE artists SET name = '#{params[:name]}' WHERE id = #{params[:id]} RETURNING *"
    result = SqlRunner.run(sql).first
    return result
  end

  def self.destroy( id )
    sql = "DELETE FROM artists WHERE id = #{id}"
    SqlRunner.run(sql)
  end

end
