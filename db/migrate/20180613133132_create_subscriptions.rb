class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id#, foreign_key: true
      t.integer :plan_id#, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.float :price
      t.boolean :status
      t.integer :no_of_days

      t.timestamps
    end
  end
end
