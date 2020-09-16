

class Show < ApplicationRecord
    # include Extensions::UUID
    
    # has_many :show_sets
    # has_many :songs, through: :show_sets
    # has_many :song_occurences
    has_many :fave_shows, :foreign_key => :show_uuid, :primary_key => :id
    has_many :users, through: :fave_shows
    has_many :comment_shows, :foreign_key => :show_uuid, :primary_key => :id
    has_many :vote_shows
    
    

    def setlist
        self.song_occurences.map{|songOcc| songOcc.song_ref.name}
    end


    
end

