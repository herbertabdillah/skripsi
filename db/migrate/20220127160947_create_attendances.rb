class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :week_number
      t.boolean :attended

      t.timestamps
    end
  end
end
