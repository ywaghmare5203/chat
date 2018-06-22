class AddAttachmentRequirementImageToBuyerRequirements < ActiveRecord::Migration[5.1]
  def self.up
    change_table :buyer_requirements do |t|
      t.attachment :requirement_image
    end
  end

  def self.down
    remove_attachment :buyer_requirements, :requirement_image
  end
end
