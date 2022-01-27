class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.boolean :graduated

      t.timestamps
    end
  end
end
