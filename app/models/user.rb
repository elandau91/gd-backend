class User < ApplicationRecord
    has_secure_password
    has_many :fave_shows
    has_many :shows, through: :fave_shows
    has_many :comment_shows
    validates :username, uniqueness: { case_sensitive: false }
    
    
    def faves
        self.fave_shows.count
    end
    
end