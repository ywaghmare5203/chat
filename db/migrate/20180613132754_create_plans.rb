class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.boolean :status
      t.string :duration

      t.timestamps
    end
  end
end
