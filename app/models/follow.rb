class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followee, class_name: 'User'
    validates :followee, uniqueness: {scope: :follower}
    validate :doesnt_follow_self

  private

  def doesnt_follow_self
    errors.add(:base, 'You can\'t follow yourself') if follower == followee
  end

    
end