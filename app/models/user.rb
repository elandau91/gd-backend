class User < ApplicationRecord
    has_secure_password
    has_many :fave_shows
    has_many :shows, through: :fave_shows
    has_many :comment_shows
    validates :username, uniqueness: { case_sensitive: false }

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users 

    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users 
    
    
    def faves
        self.fave_shows.count
    end
    
end