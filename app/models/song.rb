class Song < ActiveRecord::Base
	include Extensions::UUID
  
	belongs_to :show_set, :foreign_key => :show_set_uuid, :primary_key => :uuid
	belongs_to :song_ref, :foreign_key => :song_ref_uuid, :primary_key => :uuid
	
	def self.create_from(spec)
    song = Song.new
    set_spec(song, spec)
    #byebug
    # song_ref = SongRef.find_by_name(spec[:name])
    song.save
    
    create_song_relationships(spec)
    Song.find_by_uuid(spec[:uuid])
  end

  def self.create_song_relationships(spec)
    song_ref = SongRef.find_by_name(spec[:name])
    raise "Unable to find a song ref named #{spec[:name]} #{spec.inspect}" unless song_ref
    #byebug
    song_ref.songs << Song.find_by_uuid(spec[:uuid])
    song_ref.song_occurences << SongOccurence.create_from(uuid: SecureRandom.uuid, position: spec[:position], show_set_uuid: spec[:show_set_uuid])
    song_ref.save
  end

  def self.update_from(spec)
    song = Song.find_by_uuid(spec[:uuid])
    set_spec(song, spec)
    song.save
    song
  end

  def self.update_song_relationships(spec)
    remove_song_relationships(spec)
    create_song_relationships(spec)
  end
  
  def self.remove_from(spec)
    remove_song_relationships(spec)
    song = Song.find_by_uuid(spec[:uuid])
    song.delete if song
  end

  def self.remove_song_relationships(spec)
    song_ref = SongRef.find_by_name(spec[:name])
    return unless song_ref
    
    song = Song.find_by_uuid(spec[:uuid])
    return unless song

    song_ref.songs.delete(song) if song_ref.songs
    show_set = ShowSet.find_by_uuid(spec[:show_set_uuid])
    
    show = ShowSet.find_by_uuid(spec[:show_set_uuid]).show

    song_ref.song_occurences.where('show_uuid = ? and song_ref_uuid = ?', show.uuid, song_ref.uuid).each do | occurence|
      song_ref.song_occurences.delete(occurence)
      occurence.delete
    end
  end

  def self.find_all_by_year(year)
    Song.joins(:show_set => [:show]).where('shows.year = ?', year)
  end

  private 
  def self.remove_name(spec)
    spec.reject {|k,v| k == :name }
  end

  def self.set_spec(song, spec)
    song_ref = SongRef.find_by_name(spec[:name])
    song.uuid = spec[:uuid]
    #byebug
    song.song_ref_uuid = song_ref[:uuid]
    song.show_set_uuid = spec[:show_set_uuid]
    song.show_set = spec[:show_set]
    song.position = spec[:position]
    song.segued = spec[:segued]
    song.show_set = ShowSet.find_by_uuid(spec[:show_set_uuid])
    #byebug
    song
  end
end