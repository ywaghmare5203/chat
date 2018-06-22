class BuyerRequirementSerializer < ActiveModel::Serializer
  # attributes to be serialized  
  attributes :id, :title,:description,:country, :city, :user_id, :requirement_image
  # model association
  has_many :comments, as: :commentable
end
