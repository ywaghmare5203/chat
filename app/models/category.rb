class Category < ApplicationRecord
  has_attached_file :category_image, { url: "/system/User/:id/category_image/#{Digest::SHA256.base64digest("yogesh")[0..20]}/category_image.:extension"}
  validates_attachment_content_type :category_image, content_type: /\Aimage/
  validates_attachment_file_name :category_image, matches: [/png\z/, /jpe?g\z/]
  do_not_validate_attachment_file_type :category_image
end

