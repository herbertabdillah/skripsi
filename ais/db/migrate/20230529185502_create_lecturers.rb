class CreateLecturers < ActiveRecord::Migration[6.1]
  def change
    create_table :lecturers do |t|
      t.string :name
      t.string :nik

      t.timestamps
    end
  end
end
