class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :class_number
      t.integer :pair_set
      t.integer :first_id
      t.integer :second_id
      t.string :first_full_name
      t.string :second_full_name

      t.timestamps null: false
    end
  end
end
