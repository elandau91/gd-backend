class Show < ApplicationRecord
    has_many :show_sets
    has_many :songs, through: :show_sets
    has_many :song_occurences
    
    def setlist
    
        self.song_occurences.map {|songOcc| songOcc.song_ref.name}
    end



    
end

