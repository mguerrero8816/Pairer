class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :class_number
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
