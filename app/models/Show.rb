class Show < ApplicationRecord
    has_many :show_sets
    has_many :songs, through: :show_sets
    has_many :song_occurences
    has_many :fave_shows
    has_many :users, through: :fave_shows
    has_many :comment_shows
    

    def setlist
        self.song_occurences.map{|songOcc| songOcc.song_ref.name}
    end
    
end

