class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :avatar
  has_many :fave_shows
  has_many :shows, through: :fave_shows
end
