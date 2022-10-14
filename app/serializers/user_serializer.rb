class UserSerializer < ActiveModel::Serializer

  has_many :recipes

  attributes :id, :username, :bio, :image_url
  
end