class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :department, null: false, foreign_key: true
      t.string :kind
      t.integer :credit

      t.timestamps
    end
  end
end
