class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :nim
      t.references :department, null: false, foreign_key: true
      t.integer :entry_year
      t.string :status
      t.references :supervisor_lecturer, index: true, foreign_key: { to_table: :lecturers }

      t.timestamps
    end
  end
end
