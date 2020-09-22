# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#name change test

require 'faker'



require 'yaml'
require 'securerandom'
# require 'gdshowsdb'



# Show.destroy_all
# ShowSet.destroy_all
# SongRef.destroy_all
# SongOccurence.destroy_all
# Song.destroy_all
User.destroy_all
FaveShow.destroy_all
CommentShow.destroy_all
# VoteShow.destroy_all
Follow.destroy_all



	def song_reffies
		File.open "/Users/elilandau/Development/code/Mod5/gd_capstone/gdshowsdb/data/gdshowsdb/song_refs.yaml"
	end

	def parse_reffies
		self.map do |song_ref|
		  key = song_ref.keys.first
		  value = song_ref[key]
		  { uuid: value, name: key }
		end        
	end

	

	def song_ref_creator	
		song_ref_yaml_parser = YAML::load(song_reffies())
		song_ref_yaml_parser.send(:parse_reffies).each do |song_ref_hash|
			SongRef.create_from(song_ref_hash)
		end		
	end


	def data (year) 
		File.open "/Users/elilandau/Development/code/Mod5/gd_capstone/gdshowsdb/data/gdshowsdb/#{year}.yaml"
	end

# data = File.open "/Users/elilandau/Development/code/Mod5/gd_capstone/gdshowsdb/data/gdshowsdb/#{year}.yaml"
	def parse_shows
		parsed = []
		self.each do |key, value|
		date_info = Show.parse_date(key)
		parsed.push(date_info.merge({uuid: value[:uuid], venue: value[:venue], city: value[:city], state: value[:state], country: value[:country]}))
		end
		parsed
	end

	def parse_sets     
		parsed_sets = []
		
		self.each do |show_date, show| 
		  sets = show[:sets]
		  if sets && !sets.empty?
			sets.each_with_index do |set, i|
			  parsed_sets.push(
				{uuid: set[:uuid], show_uuid: show[:uuid], position: i, encore: ShowSet.encore?(sets, set)}
			  )
			end
		  end
		end
  
		parsed_sets
	  end

	  def parse_songs      
		parsed = []
		#byebug
		self.each do |key, value|
		  sets = value[:sets]
		  sets.each do |set|
			songs = set[:songs]
			songs.each_with_index do |song, i|
			  parsed << song.merge({position: i, show_set_uuid: set[:uuid]})
			end if songs          
		  end if sets       
		end
		parsed
	  end

	
	def seed_shows
		# include Gdshowsdb
		(1965..1995).each do |year|
			
			create_shows(year)
			create_sets(year)
			create_songs(year)			
		end
	end


	def create_shows(year)
		# include Gdshowsdb
		show_yaml_parser = YAML::load(data(year))	
			#byebug
		show_yaml_parser.send(:parse_shows).each do |show_yaml|
			show = Show.create(show_yaml)
			puts "Created #{show.title}"
		end
	end	

	def create_sets(year)
		# include Gdshowsdb
		set_yaml_parser = YAML::load(data(year))	
		set_yaml_parser.send(:parse_sets).each do |set_yaml|
			ShowSet.create_from(set_yaml)
		end
	end

	def create_songs(year)
		# include Gdshowsdb
		song_yaml_parser = YAML::load(data(year))	
		song_yaml_parser.send(:parse_songs).each do |song_yaml|
			Song.create_from(song_yaml)
		end
	end




	
	
	# song_ref_creator	
	# seed_shows
	
u1 = User.create(username: "elandau", password: "pw", avatar: "https://www.dead.net/sites/g/files/g2000007851/files/2018-10/jerry.jpg", email: "eli@gmail")
u2 = User.create(username: "chiara", password: "pw", avatar: "img", email: "chiara@gmail")
u3 = User.create(username: "greg", password: "pw", avatar: "img", email: "greg@gmail")

5.times do
    User.create(username: Faker::Science.element, password: Faker::Color.color_name, avatar: Faker::Fillmurray.image, email: "gmail@gmail.com")
end

20.times do
    Follow.create(follower_id: User.all.sample.id, followee_id: User.all.sample.id)
end
	
fs1 = FaveShow.create(user: u1, show_id: "02b4fd1d-523d-4dc4-9f85-e184a93ab6bb")
fs2 = FaveShow.create(user: u1, show_id: "40cb4e0a-7c88-4f44-bf87-2596c174b699")
fs3 = FaveShow.create(user: u1, show_id: "c690e235-c53d-4353-8bed-6c6a9a633054")

20.times do
    FaveShow.create(user_id: User.all.sample.id, show_id: Show.all.sample.uuid)
end

c1 = CommentShow.create(user_id: User.all.sample.id, show_id: "40cb4e0a-7c88-4f44-bf87-2596c174b699", content: Faker::Music::GratefulDead.song)
c2 = CommentShow.create(user_id: User.all.sample.id, show_id: "40cb4e0a-7c88-4f44-bf87-2596c174b699", content: Faker::Music::GratefulDead.song)

20.times do
    CommentShow.create(user_id: User.all.sample.id, show_id: Show.all.sample.uuid, content: Faker::Music::GratefulDead.song)
end




puts "done!"