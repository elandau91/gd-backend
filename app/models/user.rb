class User < ApplicationRecord
    has_many :fave_shows
    has_many :shows, through: :fave_shows
    has_many :comment_shows
    
    def faves
        self.fave_shows.count
    end
    
end