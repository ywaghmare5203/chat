class AddAttachmentCategoryImageToCategories < ActiveRecord::Migration[5.1]
  def self.up
    change_table :categories do |t|
      t.attachment :category_image
    end
  end

  def self.down
    remove_attachment :categories, :category_image
  end
end
