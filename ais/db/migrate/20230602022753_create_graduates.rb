class CreateGraduates < ActiveRecord::Migration[6.1]
  def change
    create_table :graduates do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :score
      t.integer :year

      t.timestamps
    end
  end
end
