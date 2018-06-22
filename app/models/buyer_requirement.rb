class BuyerRequirement < ApplicationRecord
  has_attached_file :requirement_image, { url: "/system/User/:id/requirement_image/#{Digest::SHA256.base64digest("yogesh")[0..20]}/requirement_image.:extension"}
  validates_attachment_content_type :requirement_image, content_type: /\Aimage/
  validates_attachment_file_name :requirement_image, matches: [/png\z/, /jpe?g\z/]
  do_not_validate_attachment_file_type :requirement_image

  has_many :comments, as: :commentable
  belongs_to :user, optional: true

  def self.upload_requirement_image(image)
     puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSGGGGGGGGGGGGGGGGGGGGGGAAAAAAAAAAAAAAA#{image.inspect}"
  end
end
