class CreateBuyerRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :buyer_requirements do |t|
      t.string :title
      t.text :description
      t.string :country
      t.string :city
      t.integer :user_id#, foreign_key: true
      t.string :area

      t.timestamps
    end
  end
end
