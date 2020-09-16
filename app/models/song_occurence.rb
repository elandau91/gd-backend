class SongOccurence < ApplicationRecord
    belongs_to :show
    belongs_to :song_ref

    def name 
        puts "#{self.song_ref.name}"
    end
    
end